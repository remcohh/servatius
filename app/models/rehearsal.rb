class Rehearsal < ApplicationRecord
  belongs_to :band
  has_many :member_presences, as: :presentable

  scope :upcoming_for_band, ->(band_id) {
    where('date(date_time) >= current_date')
        .where(band_id: band_id)
        .order('date_time asc')
  }

  def is_declined_by?(member)
    member_presences.where(member_id: member.id).where(will_be_present: false).count > 0
  end

end
