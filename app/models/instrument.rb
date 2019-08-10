class Instrument < ApplicationRecord
  has_many :members

  has_many :ensemble_instruments

end
