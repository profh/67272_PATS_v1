class Dosage < ApplicationRecord

  # Relationships
  belongs_to :medicine
  belongs_to :visit
  has_one :pet, through: :visit

  # Scopes
  scope :for_medicine,  ->(medicine_id) { where(medicine_id: medicine_id) }
  scope :for_visit,     ->(visit_id) { where(visit_id: visit_id) }
  
  # Validations
  validates_numericality_of :discount, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1
  validates_numericality_of :units_given, :greater_than => 0, :only_integer => true
  # make sure the medicine selected is one that is offered by PATS
  validate :medicine_actively_offered_by_PATS
  # make sure that the medicine is appropriate for the animal getting it
  validate :medicine_matches_animal_type

  # Use private methods to execute the custom validations
  # -----------------------------
  private
  def medicine_actively_offered_by_PATS
    # get an array of all medicine ids PATS currently has
    possible_medicine_ids = Medicine.active.all.map{|v| v.id}
    # add error unless the medicine id is in the array of possible medicines
    unless possible_medicine_ids.include?(self.medicine_id)
      errors.add(:medicine, "is not currently available at PATS")
    end
  end

  def medicine_matches_animal_type
    # already require visit, but shoulda matchers will try this...
    return true if self.visit.nil?
    # find the animal type for the visit in question
    animal = self.visit.pet.animal
    # get an array of all medicine ids this animal can get
    possible_medicine_ids = Medicine.for_animal(animal.id).map{|v| v.id}
    # add error unless the medicine id is in the array of possible medicine
    unless possible_medicine_ids.include?(self.medicine_id)
      errors.add(:medicine, "is inappropriate for this animal")
    end
  end

end
