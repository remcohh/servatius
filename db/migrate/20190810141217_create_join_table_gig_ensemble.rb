class CreateJoinTableGigEnsemble < ActiveRecord::Migration[5.2]
  def change
    create_join_table :gigs, :ensembles do |t|
      t.index [:gig_id, :ensemble_id]
      t.index [:ensemble_id, :gig_id]
    end
  end
end
