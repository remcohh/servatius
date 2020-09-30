class AddActiveFieldsToBand < ActiveRecord::Migration[5.2]
  def change
    add_column :bands, :rehearsals_active, :boolean
    add_column :bands, :gigs_active, :boolean
    add_column :bands, :chores_active, :boolean
    add_column :bands, :statistics_active, :boolean
    add_column :bands, :website_active, :boolean
    add_column :bands, :info_active, :boolean
  end
end
