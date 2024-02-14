SET ROLE postgres;

CREATE FUNCTION fail(message text) returns boolean language plpgsql as $$
BEGIN
    RAISE EXCEPTION 'Test failed: %', message USING ERRCODE = 'diagnostics_exception';
END;
$$;

CREATE FUNCTION assert(condition boolean, message text) returns boolean language plpgsql as $$
BEGIN
    IF NOT condition OR condition IS NULL THEN
        RAISE EXCEPTION 'Test failed. Condition is [%]. Message: [%]', coalesce(condition::text, 'NULL'), message USING ERRCODE = 'diagnostics_exception';
    END IF;
    RETURN true;
END;
$$;

CREATE FUNCTION assert_equals(expected numeric, actual numeric, message text) returns boolean language plpgsql as $$
BEGIN
    IF expected IS DISTINCT FROM actual THEN
        RAISE EXCEPTION 'Equality test failed. Expected [%], actual [%]. Message: [%]', coalesce(expected::text, 'NULL'), coalesce(actual::text, 'NULL'), message USING ERRCODE = 'diagnostics_exception';
    END IF;
    RETURN true;
END;
$$;

CREATE FUNCTION assert_null(actual numeric, message text) returns boolean language plpgsql as $$
BEGIN
    IF actual IS NOT NULL THEN
        RAISE EXCEPTION 'Null check failed. Expected [NULL], actual [%]. Message: [%]', coalesce(actual::text, 'NULL'), message USING ERRCODE = 'diagnostics_exception';
    END IF;
    RETURN true;
END;
$$;

CREATE FUNCTION assert_not_null(actual numeric, message text = null) returns boolean language plpgsql as $$
BEGIN
    IF actual IS NULL THEN
        RAISE EXCEPTION 'Not null check failed. Expected [NOT NULL], actual [NULL]. %', case when message is not null then 'Message ' || message END USING ERRCODE = 'diagnostics_exception';
    END IF;
    RETURN true;
END;
$$;

CREATE FUNCTION assert_true(actual boolean, message text = null) returns text language plpgsql as $$
BEGIN
    IF NOT actual THEN
        RAISE EXCEPTION 'True check failed. Expected [TRUE], actual [%]. Message: [%]', coalesce(actual::text, 'NULL'), coalesce(message::text, 'NULL') USING ERRCODE = 'diagnostics_exception';
    END IF;
    RETURN coalesce('OK - ' || message, 'OK');
END;
$$;

