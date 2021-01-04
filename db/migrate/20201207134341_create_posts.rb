class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :page, null: true, foreign_key: true
      t.string :name
      t.string :slug, unique: true
      t.string :subname
      t.string :headline
      t.text :body
      t.text :summary
      t.string :url_video
      t.boolean :active, default: false
      t.boolean :feature_post, default: false

      t.timestamps
    end
  end
end
