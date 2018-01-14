class Treatment < ApplicationRecord
  # Relationships
  belongs_to :visit
  belongs_to :procedure
  has_one :pet, :through => :visit

  # Scopes
  scope :for_procedure, ->(procedure_id) { where("procedure_id = ?", procedure_id) }
  scope :for_visit,     ->(visit_id) { where("visit_id = ?", visit_id) }
  scope :alphabetical,  -> { joins(:procedure).order("procedures.name") }
  
  # Validations
  validates_numericality_of :discount, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1
end
