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
  has_many :member_presences, as: :presentable
  has_and_belongs_to_many :ensembles
  has_many :ensemble_instruments, through: :ensembles
  has_many :members, through: :ensemble_instruments


  #validate :check_gig_admin_has_permission


  scope :past, -> { where(when: Time.now - 1.year..Time.now ) }
  scope :future, -> { where(when: Time.now..Time.now + 2.years) }

  def players
    members
  end

  def presence_for_member(member)
    member_presences.where(member: member).first.try(:will_be_present)
  end

  def is_declined_by?(member)
    presence_for_member(member) == false
  end

  def is_accepted_by?(member)
    presence_for_member(member) == true
  end

  def self.members_for_gig_and_ensemble_instrument(gig_id, ensemble_instrument_id, present )

    # Member.joins(:member_presences)
    #       .joins(:ensemble_instrument_members)
    #       .joins(:ensemble_instrument)
    #       .where('members.instrument_id = ?', instrument_id)
    #       .where('member_presences.presentable_id = ?',gig_id )
    #       .where('member_presences.presentable_type = ?','Gig' )
    #       .where('member_presences.will_be_present = ?', present)
    #       .order('members.last_name asc')


    EnsembleInstrument.find(ensemble_instrument_id).members
                      .joins(:member_presences)
                      .where('member_presences.presentable_id = ?',gig_id )
                      .where('member_presences.presentable_type = ?','Gig' )
                      .where('member_presences.will_be_present = ?', present)
                      .order('members.last_name asc')
  end

  private

  def check_gig_admin_has_permission
    errors.add(:gig_admin, 'is not allowed') unless gig_admin.gig_admin?
  end
end
