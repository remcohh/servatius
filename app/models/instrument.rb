class Instrument < ApplicationRecord
  has_many :members

  has_many :ensemble_instruments, dependent: :destroy

  scope :for_band, ->(band) {
    where(band_id: band)
  }

end
