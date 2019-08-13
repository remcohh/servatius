class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :composer
      t.string :state
      t.references :ensemble

      t.timestamps
    end
  end
end
