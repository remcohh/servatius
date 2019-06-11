class Gig < ApplicationRecord
  belongs_to :gig_admin, class_name: 'Member'
  has_and_belongs_to_many :members
  validate :check_gig_admin_has_permission


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
