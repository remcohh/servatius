class AddFieldsToGig < ActiveRecord::Migration[5.2]
  def change
    add_column :gigs, :gather_when, :datetime
    add_column :gigs, :gather_where, :string
    add_column :gigs, :dresscode, :string
    add_column :gigs, :where_address1, :string
    add_column :gigs, :where_address2, :string
    add_column :gigs, :member_remarks, :text
    add_column :gigs, :site_remarks, :text
    remove_column :gigs, :high_payer
    remove_column :gigs, :charity
  end
end
