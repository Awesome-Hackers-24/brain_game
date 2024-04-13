CREATE TABLE sensor_data (
    id SERIAL PRIMARY KEY,
    pos1 NUMERIC,
    pos2 NUMERIC,
    pos3 NUMERIC,
    pos4 NUMERIC,
    pos5 NUMERIC,
    pos6 NUMERIC,
    pos7 NUMERIC
);

INSERT INTO sensor_data (pos1, pos2, pos3, pos4, pos5, pos6, pos7)
VALUES
(-344793, -337291, -352634, -348493, -6164596, -5920204, -6212305);

UPDATE sensor_data
SET
    pos1 = -344793,
    pos2 = -337291,
    pos3 = -352634,
    pos4 = -348493,
    pos5 = -6164596,
    pos6 = -5920204,
    pos7 = -6212305
WHERE id = 1;


UPDATE sensor_data
SET
    pos1 = -344786,
    pos2 = -337291,
    pos3 = -352621,
    pos4 = -348490,
    pos5 = -6164637,
    pos6 = -5920253,
    pos7 = -6212343
WHERE id = 1;
