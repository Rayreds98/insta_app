class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :name
      t.text :biography
      t.date :birthday
      t.text :website
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :profiles, [:user_id, :created_at]
  end
end
