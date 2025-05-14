class CreateEssayTopics < ActiveRecord::Migration[8.0]
  def change
    create_table :essay_topics do |t|
      t.references :essay, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end

    add_index :essay_topics, [ :essay_id, :topic_id ], unique: true
  end
end
