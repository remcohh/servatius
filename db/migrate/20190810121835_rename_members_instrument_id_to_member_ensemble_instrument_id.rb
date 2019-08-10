class RenameMembersInstrumentIdToMemberEnsembleInstrumentId < ActiveRecord::Migration[5.2]
  def change
    rename_column :members, :instrument_id, :ensemble_instrument_id
  end
end
