
CREATE TABLE tickets (
    id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title        VARCHAR2(100) NOT NULL,
    status       VARCHAR2(200) NOT NULL,
    priority        VARCHAR2(50)  NOT NULL,
    assigned_to   NUMBER         REFERENCES users(id),
    created_at  TIMESTAMP     DEFAULT SYSTIMESTAMP,
    resolved_at  TIMESTAMP     DEFAULT SYSTIMESTAMP
);

CREATE TABLE ticket_assignments (
    id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ticket_id        NUMBER         REFERENCES tickets(id),
    assigned_to   NUMBER         REFERENCES users(id),
    assigned_by   NUMBER         REFERENCES users(id),
    valid_from  TIMESTAMP     DEFAULT SYSTIMESTAMP,
    valid_to  TIMESTAMP     DEFAULT SYSTIMESTAMP
);


## Step 2 — Sample Data

Insert at least 5 tickets. Make sure at least one gets reassigned (different
person in `ticket_assignments` than the current `assigned_to` in `tickets`).

```sql
-- ============================================================
-- STEP 2 — Sample Data
-- ============================================================

INSERT INTO tickets (title, status, priority, assigned_to, created_at, resolved_at) VALUES
('Fix UI', 'completed', 'high', 1, TIMESTAMP '2026-02-01 09:00:00', TIMESTAMP '2026-02-02 14:00:00');

INSERT INTO tickets (title, status, priority, assigned_to, created_at, resolved_at) VALUES
('API timeout error', 'in_progress', 'critical', 2, TIMESTAMP '2026-02-02 10:00:00', NULL);

INSERT INTO tickets (title, status, priority, assigned_to, created_at, resolved_at) VALUES
('Login page broken', 'completed', 'high', 3, TIMESTAMP '2026-02-03 08:30:00', TIMESTAMP '2026-02-04 11:00:00');

INSERT INTO tickets (title, status, priority, assigned_to, created_at, resolved_at) VALUES
('Export CSV feature', 'open', 'low', 1, TIMESTAMP '2026-02-04 13:00:00', NULL);

-- Reassigned ticket: originally agent 2, now agent 4
INSERT INTO tickets (title, status, priority, assigned_to, created_at, resolved_at) VALUES
('Payment gateway crash', 'completed', 'critical', 4, TIMESTAMP '2026-02-05 09:00:00', TIMESTAMP '2026-02-06 16:00:00');


-- ============================================================
-- STEP 3 — Trigger
-- ============================================================

CREATE OR REPLACE TRIGGER trg_ticket_assignment
AFTER INSERT OR UPDATE OF assigned_to ON tickets
FOR EACH ROW
WHEN (NEW.assigned_to IS NOT NULL)
BEGIN
    -- Close the previous active assignment (valid_to = now)
    UPDATE ticket_assignments
    SET    valid_to = SYSTIMESTAMP
    WHERE  ticket_id = :NEW.id
      AND  valid_to  IS NULL;

    -- Open a new assignment row
    INSERT INTO ticket_assignments (ticket_id, assigned_to, assigned_by, valid_from, valid_to)
    VALUES (:NEW.id, :NEW.assigned_to, :NEW.assigned_to, SYSTIMESTAMP, NULL);
END;
/

-- TEST: reassign ticket 178 and verify history
UPDATE tickets SET assigned_to = 3 WHERE id = 178;

-- Confirm both rows exist
SELECT * FROM ticket_assignments WHERE ticket_id = 178 ORDER BY valid_from;


-- ============================================================
-- STEP 4 — Data Warehouse Tables (Star Schema)
-- ============================================================

CREATE TABLE dim_agent (
    agent_key   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    agent_name  VARCHAR2(100) NOT NULL,
    team        VARCHAR2(100) NOT NULL
);

CREATE TABLE fact_ticket_daily (
    date_key          DATE          NOT NULL,
    agent_key         NUMBER        REFERENCES dim_agent(agent_key),
    status            VARCHAR2(200) NOT NULL,
    priority          VARCHAR2(50)  NOT NULL,
    tickets_created   NUMBER        DEFAULT 0,
    tickets_resolved  NUMBER        DEFAULT 0,
    CONSTRAINT pk_fact_ticket_daily PRIMARY KEY (date_key, agent_key, status, priority)
);


-- ============================================================
-- STEP 5 — Populate dim_agent
-- ============================================================

INSERT INTO dim_agent (agent_name, team) VALUES ('Alice Gomez',   'Frontend');
INSERT INTO dim_agent (agent_name, team) VALUES ('Bob Ramirez',   'Backend');
INSERT INTO dim_agent (agent_name, team) VALUES ('Clara Soto',    'DevOps');
INSERT INTO dim_agent (agent_name, team) VALUES ('Diego Fuentes', 'Backend');


-- ============================================================
-- STEP 6 — ETL Logic (Python / pandas for Colab)
-- ============================================================

/*
import pandas as pd
from sqlalchemy import create_engine, text

engine = create_engine("oracle+cx_oracle://user:pass@host/dbname")

# 1. Extract
tickets     = pd.read_sql("SELECT * FROM tickets",            engine)
assignments = pd.read_sql("SELECT * FROM ticket_assignments", engine)

# Ensure timestamps are datetime
for col in ["valid_from", "valid_to"]:
    assignments[col] = pd.to_datetime(assignments[col])
for col in ["created_at", "resolved_at"]:
    tickets[col] = pd.to_datetime(tickets[col])

def find_agent(ticket_id, moment, assignments):
    """Return assigned_to for a ticket at a given moment."""
    if pd.isna(moment):
        return None
    mask = (
        (assignments["ticket_id"] == ticket_id) &
        (assignments["valid_from"] <= moment) &
        (assignments["valid_to"].isna() | (assignments["valid_to"] > moment))
    )
    rows = assignments[mask]
    return int(rows.iloc[0]["assigned_to"]) if not rows.empty else None

# 2 & 3. Find agent at creation and resolution
tickets["creator_agent"] = tickets.apply(
    lambda r: find_agent(r["id"], r["created_at"],  assignments), axis=1
)
tickets["resolver_agent"] = tickets.apply(
    lambda r: find_agent(r["id"], r["resolved_at"], assignments), axis=1
)

# 4. Build created counts
created = (
    tickets.dropna(subset=["creator_agent"])
    .assign(date_key=tickets["created_at"].dt.date)
    .
```

---
