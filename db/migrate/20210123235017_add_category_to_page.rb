class AddCategoryToPage < ActiveRecord::Migration[6.0]
  def change
    add_reference :pages, :category, null: true, foreign_key: true
    add_column :categories, :show_on_home, :boolean, default: false
  end
end
