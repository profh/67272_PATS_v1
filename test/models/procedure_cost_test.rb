require 'test_helper'

class ProcedureCostTest < ActiveSupport::TestCase
# Relationship matchers...
  should belong_to(:procedure)
  
  # Validation matchers...
  should validate_numericality_of(:cost).only_integer.is_greater_than_or_equal_to(0)
  should allow_value(Date.current).for(:start_date)
  should allow_value(1.day.ago.to_date).for(:start_date)
  should allow_value(1.day.from_now.to_date).for(:start_date)
  should_not allow_value("bad").for(:start_date)
  should_not allow_value(2).for(:start_date)
  should_not allow_value(3.14159).for(:start_date)

  context "Creating context" do
    setup do 
      create_procedures
      create_procedure_costs
    end
    
    teardown do
      destroy_procedure_costs
      destroy_procedures
    end
  
    # test the scope 'chronological'
    should "shows that procedure_costs are listed in chronological order" do
      assert_equal [@checkup_c1, @xray_c1, @dental_c1, @checkup_c2], ProcedureCost.chronological.to_a
    end
    
    # test the scope 'current'
    should "shows that there are three procedures with current cost" do
      assert_equal [2000, 3000, 4000], ProcedureCost.current.map{|o| o.cost}.sort
    end

  end
end
