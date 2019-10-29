class Message < ApplicationRecord
  belongs_to :messageable, polymorphic: true
  belongs_to :member

  has_one_attached :upload

  def self.for_member(member)
    t = Time.now
    ensemble_messages = member.ensembles.collect { |e| e.messages }.flatten
    group_messages = member.groups.collect { |e| e.messages }.flatten
    (ensemble_messages + group_messages).sort_by{ |e| t - e.created_at }
  end

end
