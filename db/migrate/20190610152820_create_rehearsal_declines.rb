class CreateRehearsalDeclines < ActiveRecord::Migration[5.2]
  def change
    create_table :rehearsal_declines do |t|
      t.references :member, foreign_key: true
      t.references :rehearsal, foreign_key: true

      t.timestamps
    end
  end
end
