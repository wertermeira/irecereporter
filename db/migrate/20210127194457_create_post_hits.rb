class CreatePostHits < ActiveRecord::Migration[6.0]
  def change
    create_table :post_hits do |t|
      t.references :post, null: false, foreign_key: true
      t.date :hit_day
      t.integer :hits, default: 0

      t.timestamps
    end
  end
end
