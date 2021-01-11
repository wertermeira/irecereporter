class CreateGalleries < ActiveRecord::Migration[6.0]
  def change
    create_table :galleries do |t|
      t.references :post, null: true, foreign_key: true

      t.timestamps
    end
  end
end
