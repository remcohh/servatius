class GigsRenameWhenToDateTime < ActiveRecord::Migration[5.2]
  def change
    rename_column :gigs, :when, :date_time
  end
end
