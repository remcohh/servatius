class EnsembleInstrument < ApplicationRecord
  belongs_to :ensemble
  belongs_to :instrument

  validates :instrument_id, uniqueness: { scope: :ensemble_id, message: 'Instrument is al toegevoegd' }
end
