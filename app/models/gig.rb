class Gig < ApplicationRecord
  has_many :member_presences, as: :presentable
  has_and_belongs_to_many :ensembles
  has_many :ensemble_instruments, through: :ensembles
  has_many :members, through: :ensemble_instruments
  has_many :playable_songs, as: :playable
  has_many :songs, through: :playable_songs

  accepts_nested_attributes_for :playable_songs, reject_if: proc{ |attr| attr[:song_id].blank? }, allow_destroy: true

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

  scope :upcoming_for_ensemble, ->(ensemble) {
    ensemble.gigs
        .where('date(date_time) >= current_date')
        .order('date_time asc')
  }





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
    EnsembleInstrument.find(ensemble_instrument_id).members
                      .joins(:member_presences)
                      .where('member_presences.presentable_id = ?',gig_id )
                      .where('member_presences.presentable_type = ?','Gig' )
                      .where('member_presences.will_be_present = ?', present)
                      .order('members.last_name asc')
  end

  def instruments_availabability(ensemble)
    query="SELECT instruments.id, ensemble_instruments.id as ensemble_instrument_id, concat(instruments.name, ensemble_instruments.party) AS instrument_name, COUNT(CASE WHEN will_be_present THEN 1 END) AS COUNT_present,
    COUNT(CASE WHEN NOT will_be_present THEN 1 END) AS COUNT_not_present FROM instruments
    INNER JOIN ensemble_instruments ON ensemble_instruments.instrument_id=instruments.id AND ensemble_instruments.ensemble_id=#{ensemble.id}
    LEFT OUTER JOIN ensemble_instruments_members ON ensemble_instruments.id = ensemble_instruments_members.ensemble_instrument_id
    LEFT OUTER JOIN members ON members.id = ensemble_instruments_members.member_id
    LEFT OUTER JOIN member_presences ON member_presences.member_id = members.id
    AND member_presences.presentable_id=#{id} and member_presences.presentable_type='Gig'
    GROUP BY instruments.id, ensemble_instruments.id ORDER BY instruments.id"
    ActiveRecord::Base.connection.execute(query)
  end

  private

  def check_gig_admin_has_permission
    errors.add(:gig_admin, 'is not allowed') unless gig_admin.gig_admin?
  end
end
