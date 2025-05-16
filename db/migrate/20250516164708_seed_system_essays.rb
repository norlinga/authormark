class SeedSystemEssays < ActiveRecord::Migration[8.0]
  def up
    now = Time.current

    [ "index", "about", "topics" ].each do |slug|
      Essay.upsert(
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
