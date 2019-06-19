class AddReferenceToMemberPresences < ActiveRecord::Migration[5.2]
  def change
    rename_column :member_presences, :gig_id, :presentable_id
    add_column :member_presences, :presentable_type, :string
  end
end
