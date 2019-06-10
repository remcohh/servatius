class CreateRehearsals < ActiveRecord::Migration[5.2]
  def change
    create_table :rehearsals do |t|
      t.references :band, foreign_key: true
      t.string :description
      t.datetime :date_time

      t.timestamps
    end
  end
end
