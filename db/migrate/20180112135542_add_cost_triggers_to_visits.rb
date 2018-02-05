class AddCostTriggersToVisits < ActiveRecord::Migration[5.1]
  # def change
  #   say_with_time("Adding triggers related to visit costs") do
  #     execute <<-SQL
  #     CREATE OR REPLACE FUNCTION calculate_total_costs() RETURNS TRIGGER AS $$
  #     DECLARE
  #     for_visit_id integer;
  #     visit_date date;
  #     medicine_cost integer;
  #     treatment_cost integer;
  #     change_to integer;
  #     BEGIN
  #     for_visit_id = (NEW.visit_id);
  #     visit_date = (select date from visits where id = for_visit_id);
  #     medicine_cost = (
  #     select round(coalesce(sum((1.0 - discount) * units_given * cost_per_unit),0))
  #     from dosages vm join medicine_costs mc on vm.medicine_id=mc.medicine_id 
  #     where vm.visit_id = for_visit_id and mc.start_date <= visit_date and (mc.end_date >= visit_date or mc.end_date is null)
  #     );
  #     treatment_cost = (
  #     select round(coalesce(sum((1.0 - discount) * cost),0))
  #     from treatments tr join procedure_costs pc on tr.procedure_id=pc.procedure_id 
  #     where tr.visit_id = for_visit_id and pc.start_date <= visit_date and (pc.end_date >= visit_date or pc.end_date is null)
  #     );
  #     change_to = medicine_cost + treatment_cost;
  #     update visits set total_charge = change_to where id = for_visit_id;
  #     RETURN NULL;
  #     END;
  #     $$ LANGUAGE plpgsql;

  #     CREATE TRIGGER update_total_costs_for_medicines_changes
  #     AFTER INSERT OR UPDATE ON dosages
  #     FOR EACH ROW EXECUTE PROCEDURE calculate_total_costs();

  #     CREATE TRIGGER update_total_costs_for_treatments_changes
  #     AFTER INSERT OR UPDATE ON treatments
  #     FOR EACH ROW EXECUTE PROCEDURE calculate_total_costs();


  #     CREATE OR REPLACE FUNCTION recalculate_total_costs_after_deletion() RETURNS TRIGGER AS $$
  #     DECLARE
  #     for_visit_id integer;
  #     visit_date date;
  #     medicine_cost integer;
  #     treatment_cost integer;
  #     change_to integer;
  #     BEGIN
  #     for_visit_id = (OLD.visit_id);
  #     visit_date = (select date from visits where id = for_visit_id);
  #     medicine_cost = (
  #     select round(coalesce(sum((1.0 - discount) * units_given * cost_per_unit),0))
  #     from dosages vm join medicine_costs mc on vm.medicine_id=mc.medicine_id 
  #     where vm.visit_id = for_visit_id and mc.start_date <= visit_date and (mc.end_date >= visit_date or mc.end_date is null)
  #     );
  #     treatment_cost = (
  #     select round(coalesce(sum((1.0 - discount) * cost),0))
  #     from treatments tr join procedure_costs pc on tr.procedure_id=pc.procedure_id 
  #     where tr.visit_id = for_visit_id and pc.start_date <= visit_date and (pc.end_date >= visit_date or pc.end_date is null)
  #     );
  #     change_to = medicine_cost + treatment_cost;
  #     update visits set total_charge = change_to where id = for_visit_id;
  #     RETURN NULL;
  #     END;
  #     $$ LANGUAGE plpgsql;


  #     CREATE TRIGGER update_total_costs_for_medicine_deleted
  #     AFTER DELETE ON dosages
  #     FOR EACH ROW EXECUTE PROCEDURE recalculate_total_costs_after_deletion();

  #     CREATE TRIGGER update_total_costs_for_treatment_deleted
  #     AFTER DELETE ON treatments
  #     FOR EACH ROW EXECUTE PROCEDURE recalculate_total_costs_after_deletion();
  #     SQL
  #   end
  # end
end
