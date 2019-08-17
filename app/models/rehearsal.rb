class Rehearsal < ApplicationRecord
  belongs_to :band
  has_many :member_presences, as: :presentable
  has_and_belongs_to_many :ensembles
  has_many :members, through: :ensembles
  has_many :playable_songs, as: :playable
  has_many :songs, through: :playable_songs

  accepts_nested_attributes_for :playable_songs, reject_if: proc{ |attr| attr[:song_id].blank? }, allow_destroy: true

  scope :upcoming_for_ensemble, ->(ensemble) {
    ensemble.rehearsals
        .where('date(date_time) >= current_date')
        .order('date_time asc')
  }

  def is_declined_by?(member)
    member_presences.where(member_id: member.id).where(will_be_present: false).count > 0
  end

  def declined_members
    member_presences.where(member_presences: { will_be_present: false}).eager_load(:member)
  end

  def self.for_member(member)
    Rehearsal.joins(:members).where(['members.id = ?', member]).includes(:ensembles)
  end

end
