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

    # These are the magic pages that must exist in the
    # system, we create them immediately
    now = Time.current

    migration_essay_class = Class.new(ActiveRecord::Base) do
      self.table_name = 'essays'
    end

    [ "index", "about", "topics" ].each do |slug|
      migration_essay_class.upsert(
        {
          title: slug.capitalize,
          slug: slug,
          system_slug: slug,
          body: "# #{slug.capitalize}\n\n#{slug == 'topics' ? '{% topics %}' : "This is your #{slug} page."}",
          visible: true,
          first_published_at: now,
          created_at: now,
          updated_at: now
        },
        unique_by: :system_slug
      )
    end
  end
end
