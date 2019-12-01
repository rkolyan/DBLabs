CREATE TYPE fibonachi_state AS
(
	previous BIGINT,
	next BIGINT
);

CREATE OR REPLACE FUNCTION next_fibonachi(state fibonachi_state, numeric)
RETURNS fibonachi_state
AS $$
BEGIN
	RETURN ROW(state.next, state.previous + state.next)::fibonachi_state;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION last_fibonachi(state fibonachi_state)
RETURNS BIGINT
AS $$
BEGIN
	RETURN state.next;
END;
$$ LANGUAGE PLPGSQL;

CREATE AGGREGATE fibonachi_number (numeric)
(
	sfunc = next_fibonachi,
	stype = fibonachi_state,
	finalfunc = last_fibonachi,
	initcond = '(0,1)'
);
