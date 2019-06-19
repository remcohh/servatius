class AddWillBePresentToMemberPresences < ActiveRecord::Migration[5.2]
  def change
    add_column :member_presences, :will_be_present, :boolean
    remove_foreign_key :member_presences, :gigs
  end
end
