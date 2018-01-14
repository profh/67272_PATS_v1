class AddPgSearchDmetaphoneSupportFunctions < ActiveRecord::Migration[5.1]
  def change
    say_with_time("Adding support functions for pg_search :dmetaphone") do
      execute <<-SQL
      CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
      CREATE EXTENSION IF NOT EXISTS pg_trgm;

      CREATE OR REPLACE FUNCTION unnest(anyarray)
      RETURNS SETOF anyelement AS
      $BODY$
      SELECT $1[i] FROM
      generate_series(array_lower($1,1),array_upper($1,1)) i;
      $BODY$
      LANGUAGE 'sql' IMMUTABLE;

      CREATE OR REPLACE FUNCTION pg_search_dmetaphone(text) RETURNS text LANGUAGE SQL IMMUTABLE STRICT AS $function$
      SELECT array_to_string(ARRAY(SELECT dmetaphone(unnest(regexp_split_to_array($1, E'\\s+')))), ' ')
      $function$;
      SQL
    end
  end
end
