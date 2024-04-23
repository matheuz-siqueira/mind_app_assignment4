class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :tags, [:name, :user_id], unique: true 
  end
end
