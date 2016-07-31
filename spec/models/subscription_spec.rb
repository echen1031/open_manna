require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "Validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :time_zone }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :send_hour }
  end
end
