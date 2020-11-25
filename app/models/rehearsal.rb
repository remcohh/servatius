class Rehearsal < ApplicationRecord
  belongs_to :band
  has_many :member_presences, as: :presentable
  has_and_belongs_to_many :ensembles
  has_many :members, through: :ensembles
  has_many :playable_songs, as: :playable
  has_many :songs, through: :playable_songs

  accepts_nested_attributes_for :playable_songs, reject_if: proc{ |attr| attr[:song_id].blank? }, allow_destroy: true

  filterrific(
      default_filter_params: { list_filter: 'Toekomstig' },
      available_filters: [
          :description_filter,
          :list_filter
      ],
  )

  scope :description_filter, ->(description) {
    where('lower(description) like ?', "%#{description.downcase}%")
  }

  scope :sorted_by, ->(o) {
    order("date_time asc")
  }

  def registered_members
    members.includes(:member_presences).where('member_presences.will_be_present' => true)
                                        .where('member_presences.presentable_id' => id)
                                        .where('member_presences.presentable_type' => 'Rehearsal')
  end

  scope :upcoming_for_ensemble, ->(ensemble) {
    ensemble.rehearsals
        .where('date(date_time) >= current_date')
        .order('date_time asc')
  }

  scope :list_filter, ->(filter) {
    case filter
      when 'Toekomstig'
        where('date(date_time) >= current_date')
        .order('date_time asc')
      when 'Afgelopen'
        where('date(date_time) < current_date')
        .order('date_time asc')
      else
        all.order('date_time asc')
    end


  }

  def is_declined_by?(member)
    member_presences.where(member_id: member.id).where(will_be_present: false).count > 0
  end

  def is_accepted_by?(member)
    member_presences.where(member_id: member.id).where(will_be_present: true).count > 0
  end

  def is_attended_by?(member)
    member_presences.where(member_id: member.id).where(present: true).count > 0
  end

  def is_not_attended_by?(member)
    member_presences.where(member_id: member.id).where(present: false).count > 0
  end

  def accepted_members
    member_presences.where(member_presences: { will_be_present: true}).eager_load(:member)
  end

  def declined_members
    member_presences.where(member_presences: { will_be_present: false}).eager_load(:member)
  end

  def self.for_member(member)
    Rehearsal.joins(:members)
              .where(['members.id = ?', member])
              .where('date(date_time) >= current_date')
              .includes(:ensembles)
              .order(:date_time)
              .uniq
  end

  def instrument_count
    q=<<-HEREDOC
    select i.name, count(i.name) from rehearsals r
    INNER JOIN ensembles_rehearsals er on er.rehearsal_id = r.id
    INNER JOIN member_presences mp on mp.presentable_id = r.id and mp.presentable_type = 'Rehearsal'
    INNER JOIN ensemble_instruments_members eim on eim.member_id = mp.member_id
    INNER JOIN ensemble_instruments ei on ei.id = eim.ensemble_instrument_id AND ei.ensemble_id = er.ensemble_id
    INNER JOIN instruments i on ei.instrument_id = i.id
    WHERE r.id=#{r.id} AND mp.will_be_present = true
    group by i.name
    HEREDOC
    ActiveRecord::Base.connection.execute(q)
  end

  def available
    max_present ? max_present - accepted_members.count : nil
  end

end
