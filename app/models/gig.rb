class Gig < ApplicationRecord

  filterrific(
      default_filter_params: { sorted_by: "date_time asc" },
      available_filters: [
          :sorted_by,
          :title_filter
      ],
  )

  scope :title_filter, ->(title) {
    where('lower(title) like ?', "%#{title.downcase}%")
  }

  scope :sorted_by, ->(o) {
    order("date_time asc")
  }

  belongs_to :gig_admin, class_name: 'Member'
  has_many :gig_presences


  #validate :check_gig_admin_has_permission


  scope :past, -> { where(when: Time.now - 1.year..Time.now ) }
  scope :future, -> { where(when: Time.now..Time.now + 2.years) }

  def players
    members
  end

  def is_declined_by?(user)
    false
  end

  def is_accepted_by?(user)
    false
  end

  private

  def check_gig_admin_has_permission
    errors.add(:gig_admin, 'is not allowed') unless gig_admin.gig_admin?
  end
end
