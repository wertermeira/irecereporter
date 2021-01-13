class AddLegendsToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :cover_subtitle, :string
    add_column :posts, :image_subtitle, :string
  end
end
