class Chore < ApplicationRecord
  has_many :member_presences, as: :presentable
  belongs_to :band
  belongs_to :coordinator, class_name: 'Member'

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

  scope :for_band, ->(band) {
    where(band_id: band)
  }

  def member_is_present?(member)
    presences = member_presences.where(member_id: member).first
    return false if presences.nil?
    presences.present
  end

  def present_members
    member_presences.joins(:member)
  end

end
