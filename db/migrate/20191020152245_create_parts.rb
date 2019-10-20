class CreateParts < ActiveRecord::Migration[5.2]
  def change
    create_table :parts do |t|
      t.references :ensemble_instrument, foreign_key: true
      t.references :song, foreign_key: true

      t.timestamps
    end
  end
end
