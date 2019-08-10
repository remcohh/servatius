class CreateEnsembleInstruments < ActiveRecord::Migration[5.2]
  def change
    create_table :ensemble_instruments do |t|
      t.references :ensemble, foreign_key: true
      t.references :instrument, foreign_key: true

      t.timestamps
    end
  end
end
