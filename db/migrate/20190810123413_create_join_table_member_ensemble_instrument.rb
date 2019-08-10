class CreateJoinTableMemberEnsembleInstrument < ActiveRecord::Migration[5.2]
  def change
    create_join_table :members, :ensemble_instruments do |t|
       t.index [:member_id, :ensemble_instrument_id], name: 'mem_en_in'
       t.index [:ensemble_instrument_id, :member_id], name: 'ens_in_mem'
    end
  end
end
