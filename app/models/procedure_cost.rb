class ProcedureCost < ApplicationRecord
  # Relationships
  belongs_to :procedure

  # Scopes
  scope :chronological, -> { order('start_date') }
  scope :current,       -> { where(end_date: nil) }
  
  # Validations
  validates_numericality_of :cost, :only_integer => true, :greater_than_or_equal_to => 0
  validates_date :start_date
end
