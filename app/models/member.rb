class Member < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  filterrific(
      default_filter_params: { sorted_by: "last_name asc" },
      available_filters: [
          :sorted_by,
          :name_filter
      ],
  )

  has_many :member_presences

  scope :name_filter, ->(name) {
    where('lower(last_name) like ? or lower(first_name) like ?', "%#{name.downcase}%", "%#{name.downcase}%")
  }

  scope :sorted_by, ->(o) {
    order("last_name asc")
  }

  has_and_belongs_to_many :ensemble_instruments
  belongs_to :band
  has_many :gigs
  has_many :rehearsal_declines

  def admin_role
    return 'Admin' if admin?
    return 'Gig Admin' if gig_admin?
  end

  def full_name
    [first_name, last_name].join(' ')
  end

end
