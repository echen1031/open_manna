require 'rails_helper'

class TestRecord
  include ActiveModel::Model
  validates :phone_number, phone_number_format: true
  attr_accessor :phone_number
end

describe PhoneNumberFormatValidator do
  context "if attribute has an ivnalid format" do
    it "sets record to invalid" do
      invalid_formats.each do |invalid|
        record = TestRecord.new(phone_number: invalid)
        expect(record).not_to be_valid
      end
    end

    it "records an error message for the attribute" do
      invalid_formats.each do |invalid|
        record = TestRecord.new(phone_number: invalid)
        record.valid?
        expect(record.errors).not_to be_empty
      end
    end
  end

  context "attribute has a valid format" do
    it "leaves the record as valid" do
      valid_formats.each do |valid|
        record = TestRecord.new(phone_number: valid)
        expect(record).to be_valid
      end
    end
  end
end

def invalid_formats
  [
    '',
    '++7777-77-777',
    '777-7777-7777'
  ]
end

def valid_formats
  [
    '7777777777',
    '777-777-7777 ext 888'
  ]
end

