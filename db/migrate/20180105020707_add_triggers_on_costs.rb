class AddTriggersOnCosts < ActiveRecord::Migration[5.1]
  # def change
  #   say_with_time("Adding triggers related to medicine and procedure costs") do
  #     execute <<-SQL
  #     CREATE OR REPLACE FUNCTION set_end_date_for_medicine_costs() RETURNS TRIGGER AS $$
  #     DECLARE 
  #     newest_record_id integer;
  #     medicine_id_changed integer;
  #     previous_record_id integer;
  #     BEGIN
  #     newest_record_id = (select currval('medicine_costs_id_seq'));
  #     medicine_id_changed = (select medicine_id from medicine_costs where id = newest_record_id);
  #     previous_record_id = (select id from medicine_costs where medicine_id = medicine_id_changed and end_date is null and id != newest_record_id);
  #     update medicine_costs set end_date = current_date where id = previous_record_id;
  #     RETURN NULL;
  #     END;
  #     $$ LANGUAGE plpgsql;

  #     CREATE TRIGGER set_end_date_for_previous_medicine_cost
  #     AFTER INSERT ON medicine_costs
  #     EXECUTE PROCEDURE set_end_date_for_medicine_costs();

  #     CREATE OR REPLACE FUNCTION set_end_date_for_procedure_costs() RETURNS TRIGGER AS $$
  #     DECLARE 
  #     newest_record_id integer;
  #     procedure_id_changed integer;
  #     previous_record_id integer;
  #     BEGIN
  #     newest_record_id = (select currval('procedure_costs_id_seq'));
  #     procedure_id_changed = (select procedure_id from procedure_costs where id = newest_record_id);
  #     previous_record_id = (select id from procedure_costs where procedure_id = procedure_id_changed and end_date is null and id != newest_record_id);
  #     update procedure_costs set end_date = current_date where id = previous_record_id;
  #     RETURN NULL;
  #     END;
  #     $$ LANGUAGE plpgsql;

  #     CREATE TRIGGER set_end_date_for_previous_procedure_cost
  #     AFTER INSERT ON procedure_costs
  #     EXECUTE PROCEDURE set_end_date_for_procedure_costs();
  #     SQL
  #   end
  # end
end
