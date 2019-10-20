class EnsembleInstrument < ApplicationRecord
  belongs_to :ensemble
  belongs_to :instrument
  has_and_belongs_to_many :members
  has_many :parts

  validates :instrument_id, uniqueness: { scope: [:ensemble_id, :party], message: 'Instrument is al toegevoegd' }

  def name
    instrument.name
  end

  def ensemble_instrument_and_party
    "#{ensemble.name}: #{instrument.name} #{party}"
  end

  def instrument_and_party
    "#{instrument.name} #{party}"
  end
end
