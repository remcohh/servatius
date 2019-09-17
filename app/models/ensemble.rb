class Ensemble < ApplicationRecord
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

  has_many :ensemble_instruments, dependent: :destroy
  has_many :members, through: :ensemble_instruments
  has_many :songs

  has_and_belongs_to_many :gigs
  has_and_belongs_to_many :rehearsals

  belongs_to :band

end
