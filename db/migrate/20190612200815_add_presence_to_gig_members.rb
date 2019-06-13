class AddPresenceToGigMembers < ActiveRecord::Migration[5.2]
  def change
    rename_table :gigs_members, :gig_members
    add_column :gig_members, :presence, :boolean
  end
end
