class AddLinkColorToBand < ActiveRecord::Migration[5.2]
  def change
    add_column :bands, :link_color, :string
  end
end
