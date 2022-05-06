class Plan < ActiveRecord::Base
  include AASM
  extend Enumerize
  belongs_to :user
  belongs_to :product
  delegate :display_name, :name, :description, to: :product

  aasm do
    state :pending, initial: true
    state :active, :past_due, :canceled

    event :activate, after: :set_user_status do
      transitions from: [:pending, :past_due], to: :active
    end

    event :decline do
      transitions from: :active, to: :past_due
    end

    event :cancel do
      transitions from: [:past_due, :active, :pending], to: :canceled
    end
  end

  def set_user_status
    user.update_columns(status: 'active')
  end
end
