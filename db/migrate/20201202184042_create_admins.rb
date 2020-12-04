class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email, unique: true
      t.string :password_digest
      t.string :token, unique: true
      t.boolean :active
      t.integer :profile

      t.timestamps
    end
  end
end
