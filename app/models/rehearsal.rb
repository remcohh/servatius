class Rehearsal < ApplicationRecord
  belongs_to :band
  has_many :rehearsal_declines


  scope :upcoming_for_band, ->(band_id) {
    where('date(date_time) >= current_date')
        .where(band_id: band_id)
        .order('date_time asc')
  }

  def is_declined_by?(member)
    rehearsal_declines.where(member_id: member.id).count > 0
  end

end
