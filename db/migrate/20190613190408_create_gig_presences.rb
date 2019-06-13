class CreateGigPresences < ActiveRecord::Migration[5.2]
  def change
    create_table :gig_presences do |t|
      t.references :gig, foreign_key: true
      t.references :member, foreign_key: true
      t.boolean :present
      t.string :remarks

      t.timestamps
    end
  end
end
