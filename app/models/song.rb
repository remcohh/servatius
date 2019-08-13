class Song < ApplicationRecord

  filterrific(
      default_filter_params: { sorted_by: "title asc" },
      available_filters: [
          :sorted_by,
          :title_filter
      ],
  )

  scope :title_filter, ->(title) {
    where('lower(title) like ?', "%#{title.downcase}%")
  }

  scope :sorted_by, ->(o) {
    order("created_at")
  }

  has_many :playable_songs
  has_many :rehearsals, through: :playable_songs, source: 'playable', source_type: 'Rehearsal'
  has_many :gigs, through: :playable_songs, source: 'playable', source_type: 'Gig'
end
