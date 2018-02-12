require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "Validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :time_zone }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :send_hour }

    it "strips non_numerica_values from phone_number" do
      non_numeric_values = "555-555-5555"
      subscription = build(:subscription, phone_number: non_numeric_values)
      subscription.save
      expect(subscription.phone_number).to eq "+15555555555"
    end
  end

  describe "#active" do
    it "takes all the active subscriptions" do
      create(:inactive_subscription)
      create(:subscription)
      expect(Subscription.active.size).to eq 1
    end
  end

  describe "#retrieve_random_verse" do
    it "does not send same verse twice without going through whole cycle" do
      create_list(:verse, 2)
      sub = create(:subscription, stored_verse_ids: [2])
      verse = sub.retrieve_random_verse
      expect(verse.id).to eq 1
    end
  end

  describe "#store_verse" do
    it "stores the verse id into subscription" do
      create_list(:verse, 2)
      sub = create(:subscription)
      verse = Verse.first
      sub.store_verse(verse)
      sub.reload
      expect(sub.stored_verse_ids).to eq [verse.id]
    end

    it "resets the array to empty when reached all verse ids" do
      verse_1 = create(:verse)
      verse_2 = create(:verse)
      verse_3 = create(:verse)
      verse_4 = create(:verse)
      sub = create(:subscription, stored_verse_ids: [verse_1.id, verse_3.id, verse_4.id])

      expect(sub.retrieve_random_verse).to eq verse_2
      sub.store_verse(sub.retrieve_random_verse)
      expect(sub.stored_verse_ids).to eq []
    end
  end
end
