require 'test_helper'

class TreatmentTest < ActiveSupport::TestCase
  # Relationship macros
  should belong_to :visit
  should belong_to :procedure
  should have_one(:pet).through(:visit)

  # Validation macros
  should validate_numericality_of(:discount).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(1)

  context "Creating context" do
    setup do 
      create_animals
      create_owners
      create_pets
      create_visits
      create_procedures
      create_treatments
    end
    
    teardown do
      destroy_treatments
      destroy_procedures
      destroy_visits
      destroy_pets
      destroy_animals
      destroy_owners
    end
  
    # test the scope 'for_procedure'
    should "have a scope for_procedure" do
      assert_equal [@visit2_t2], Treatment.for_procedure(@xray)
    end
    
    # test the scope 'for_visit'
    should "have a scope for_visit" do
      assert_equal [@visit1_t1], Treatment.for_visit(@visit1)
    end

    # test the scope 'alphabetical'
    should "arrange treatments alphabetically by procedure name" do
      assert_equal @visit2_t2, Treatment.alphabetical.last
    end
  end
end
