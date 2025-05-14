class CreateTopics < ActiveRecord::Migration[8.0]
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.string :slug, null: false

      t.timestamps
    end
    add_index :topics, :slug, unique: true
  end
end
