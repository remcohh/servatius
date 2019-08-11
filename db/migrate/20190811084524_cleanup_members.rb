class CleanupMembers < ActiveRecord::Migration[5.2]
  def change
    remove_column :members, :gig_admin, :boolean
    remove_column :members, :ordinary_member, :boolean
    remove_column :members, :ensemble_instrument_id, :integer
    remove_column :members, :ensemble_id, :integer
    add_column :members, :role, :integer
    add_column :ensemble_instruments, :party, :string
    drop_table :rehearsal_declines
  end
end
