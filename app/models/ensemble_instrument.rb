class EnsembleInstrument < ApplicationRecord
  belongs_to :ensemble
  belongs_to :instrument
  has_and_belongs_to_many :members

  validates :instrument_id, uniqueness: { scope: :ensemble_id, message: 'Instrument is al toegevoegd' }

  def name
    instrument.name
  end

  def ensemble_and_instrument_name
    "#{ensemble.name}: #{instrument.name}"
  end


end
