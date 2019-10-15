class CreateJoinTableGroupsMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.references :band, foreign_key: true
      t.string :name
      t.string :description

      t.timestamps
    end
    create_join_table :groups, :members do |t|
      # t.index [:group_id, :member_id]
      # t.index [:member_id, :group_id]
    end
  end
end
