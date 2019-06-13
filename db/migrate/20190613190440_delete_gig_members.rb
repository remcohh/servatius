class DeleteGigMembers < ActiveRecord::Migration[5.2]
  def change
    drop_table :gig_members
  end
end
