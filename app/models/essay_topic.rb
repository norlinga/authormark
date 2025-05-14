class EssayTopic < ApplicationRecord
  belongs_to :essay
  belongs_to :topic
end
