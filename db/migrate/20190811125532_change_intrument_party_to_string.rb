class ChangeIntrumentPartyToString < ActiveRecord::Migration[5.2]
  def change
    change_column :ensemble_instruments, :party, :string
  end
end
