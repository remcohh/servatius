class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :message
      t.references :member
      t.references :messageable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
