require 'rails_helper'

RSpec.describe EssayTopic, type: :model do
  it { should belong_to(:essay) }
  it { should belong_to(:topic) }
end
