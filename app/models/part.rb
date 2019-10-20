class Part < ApplicationRecord
  belongs_to :ensemble_instrument
  belongs_to :song

  has_one_attached :upload
end
