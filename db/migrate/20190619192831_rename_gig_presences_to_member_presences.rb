class RenameGigPresencesToMemberPresences < ActiveRecord::Migration[5.2]
  def change
    rename_table :gig_presences, :member_presences
  end
end
