class Song < ApplicationRecord

  filterrific(
      default_filter_params: { sorted_by: "title asc" },
      available_filters: [
          :sorted_by,
          :title_filter,
          :ensemble_filter
      ],
  )
  has_many :parts
  accepts_nested_attributes_for :parts

  scope :title_filter, ->(title) {
    where('lower(title) like ?', "%#{title.downcase}%")
  }

  scope :ensemble_filter, ->(ensemble_id) {
    where(ensemble_id: ensemble_id)
  }

  scope :sorted_by, ->(o) {
    order("created_at")
  }

  scope :for_band, ->(band) {
    where(band_id: band)
  }

  scope :for_member, ->(member) {
    where(ensemble_id: member.ensembles.pluck(:id) )
  }

  belongs_to :ensemble

  has_many :playable_songs
  has_many :rehearsals, through: :playable_songs, source: 'playable', source_type: 'Rehearsal'
  has_many :gigs, through: :playable_songs, source: 'playable', source_type: 'Gig'
  has_many :parts
end
