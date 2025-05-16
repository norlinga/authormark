class CreateEssays < ActiveRecord::Migration[8.0]
  def up
    create_table :essays do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :body
      t.boolean :visible, default: false, null: false
      t.datetime :first_published_at
      t.string :system_slug

      t.timestamps
    end

    add_index :essays, :title, unique: true
    add_index :essays, :slug, unique: true
    add_index :essays, :system_slug, unique: true
  end
end
