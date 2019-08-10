class CreateJoinTableRehearsalEnsemble < ActiveRecord::Migration[5.2]
  def change
    create_join_table :rehearsals, :ensembles do |t|
      # t.index [:rehearsal_id, :ensemble_id]
      # t.index [:ensemble_id, :rehearsal_id]
    end
  end
end
