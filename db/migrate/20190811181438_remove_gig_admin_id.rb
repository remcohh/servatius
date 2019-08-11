class RemoveGigAdminId < ActiveRecord::Migration[5.2]
  def change
    remove_column :gigs, :gig_admin_id, :integer
  end
end
