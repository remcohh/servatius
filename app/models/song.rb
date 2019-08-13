class Song < ApplicationRecord
  has_many :playable_songs
  has_many :rehearsals, through: :playable_songs, source: 'playable', source_type: 'Rehearsal'
  has_many :gigs, through: :playable_songs, source: 'playable', source_type: 'Gig'
end
