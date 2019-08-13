class PlayableSong < ApplicationRecord
  belongs_to :song
  belongs_to :playable, polymorphic: true
end
