# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Essay.find_or_create_by(title: "A First Step in a Testing Journey") do |essay|
  essay.visible = true
  essay.body = File.read(Rails.root.join("db", "seeds", "journey.md"))
  essay.first_published_at = Time.zone.now
end

topics = [ 'ruby', 'rails', 'testing', 'Moar Stuff to Do' ]
topics.each do |topic_name|
  Topic.find_or_create_by(title: topic_name)
end
