class AddBands < ActiveRecord::Migration[5.2]
  def change
    create_table :bands do |t|
      t.string :name
      t.timestamps
    end
    add_reference :gigs, :band, foreign_key: true
    add_reference :members, :band, foreign_key: true
    add_reference :comfy_cms_sites, :band, foreign_key: true
  end
end
