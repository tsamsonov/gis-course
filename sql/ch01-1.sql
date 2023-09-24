CREATE SCHEMA IF NOT EXISTS postgis;
GRANT USAGE ON schema postgis to public;
CREATE EXTENSION IF NOT EXISTS postgis SCHEMA postgis;
ALTER DATABASE satino SET search_path=public,postgis;