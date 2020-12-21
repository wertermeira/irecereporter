class CreateBanners < ActiveRecord::Migration[6.0]
  def change
    create_table :banners do |t|
      t.string :name
      t.date :date_start, default: 'now()'
      t.date :date_end
      t.boolean :active, default: false
      t.integer :kind

      t.timestamps
    end
  end
end
