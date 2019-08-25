class Instrument < ApplicationRecord
  has_many :members
  has_many :ensemble_instruments, dependent: :destroy

  filterrific(
      default_filter_params: { sorted_by: "name asc" },
      available_filters: [
          :sorted_by,
          :name_filter
      ],
  )

  scope :name_filter, ->(name) {
    where('lower(name) like ?', "%#{name.downcase}%")
  }

  scope :sorted_by, ->(o) {
    order("created_at")
  }

  scope :for_band, ->(band) {
    where(band_id: band)
  }

end
