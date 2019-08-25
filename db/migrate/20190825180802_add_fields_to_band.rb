class AddFieldsToBand < ActiveRecord::Migration[5.2]
  def change
    add_column :bands, :font, :string
    add_column :bands, :topnav_color, :string
    add_column :bands, :topnav_color_secondary, :string
    add_column :bands, :topnav_opacity, :string
    add_column :bands, :topnav_font_size, :string
    add_column :bands, :topnav_font_color, :string
    add_column :bands, :topnav_font_color_secondary, :string

  end
end
