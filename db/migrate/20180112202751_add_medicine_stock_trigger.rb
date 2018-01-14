class AddMedicineStockTrigger < ActiveRecord::Migration[5.1]
  def change
    say_with_time("Adding triggers related to visit costs") do
      execute <<-SQL
      CREATE OR REPLACE FUNCTION decrease_stock_amount_after_dosage() RETURNS TRIGGER AS $$
      DECLARE
      last_vm_id integer;
      medicine_id_given integer;
      current_stock integer;
      amount_given integer;
      decrease_to integer;
      BEGIN
      last_vm_id = (select currval('dosages_id_seq'));
      medicine_id_given = (select medicine_id from dosages where id = last_vm_id);
      current_stock = (select stock_amount from medicines where id = medicine_id_given);
      amount_given = (select units_given from dosages where id = last_vm_id);
      decrease_to = current_stock - amount_given;
      update medicines set stock_amount = decrease_to where id = medicine_id_given;
      RETURN NULL;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER update_stock_amount_for_medicines
      AFTER INSERT ON dosages
      EXECUTE PROCEDURE decrease_stock_amount_after_dosage();
      SQL
    end
  end
end
