class AddPrimaryTopicToEssays < ActiveRecord::Migration[8.0]
  def change
    add_reference :essays, :primary_topic, foreign_key: { to_table: :topics }, null: true
  end
end
