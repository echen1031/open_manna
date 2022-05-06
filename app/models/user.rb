class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions, dependent: :destroy
  has_many :subscription_verses, dependent: :destroy
  has_many :verses, through: :subscription_verses
  has_one :plan, dependent: :destroy
  after_create :associate_plan

  def over_subscription_limit?
    subscriptions.size >= 1
  end

  def admin?
    self.email == AdminUser.first.email
  end

  def number_of_subscriptions_owned
    self.subscriptions.size
  end

  def number_of_verses_received
    self.verses.size
  end

  def associate_plan
    Plan.find_or_create_by(user_id: id)
  end
end
