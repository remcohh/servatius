class CreatePlayableSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :playable_songs do |t|
      t.references :song, foreign_key: true
      t.integer :playable_id, foreign_key: true
      t.string :playable_type
      t.string :remark

      t.timestamps
    end
  end
end
