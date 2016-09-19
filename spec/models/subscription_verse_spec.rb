require 'rails_helper'

RSpec.describe SubscriptionVerse, type: :model do
  describe "Validations" do
    it { should validate_presence_of :subscription_id }
    it { should validate_presence_of :verse_id }
  end
end
