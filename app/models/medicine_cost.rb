class MedicineCost < ApplicationRecord
  # Relationships
  belongs_to :medicine

  # Scopes
  scope :chronological, -> { order('start_date') }
  scope :current,       -> { where("end_date IS NULL") }

  # Validations
  validates_numericality_of :cost_per_unit, :only_integer => true, :greater_than_or_equal_to => 0
  validates_date :start_date

end
