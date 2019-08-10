class CreateEnsembles < ActiveRecord::Migration[5.2]
  def change
    create_table :ensembles do |t|
      t.string :name
      t.references :band
      t.timestamps
    end
    add_reference :members, :ensemble, foreign_key: true
  end
end
