SELECT assert_equals(1, (SELECT max(version)::int FROM public.flyway_schema_history WHERE version < '1000'),
                     'The last migration version test');
