class CreateChores < ActiveRecord::Migration[5.2]
  def change
    create_table :chores do |t|
      t.references :band, foreign_key: true
      t.references :coordinator, foreign_key: { to_table: 'members' }
      t.datetime :date_time
      t.string :title
      t.integer :min_number
      t.integer :max_number
      t.string :description

      t.timestamps
    end
  end
end
