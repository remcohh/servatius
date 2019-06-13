class GigPresence < ApplicationRecord
  belongs_to :gig
  belongs_to :member
end
