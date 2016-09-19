require 'rails_helper'

RSpec.describe SmsClientLogger, type: :model do
  describe "Validations" do
    it { should validate_presence_of :status_code }
    it { should validate_presence_of :status_text }
    it { should validate_presence_of :message_id }
    it { should validate_presence_of :to }
  end
end
