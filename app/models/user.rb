class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions, dependent: :destroy
  has_many :subscription_verses, dependent: :destroy
  has_many :verses, through: :subscription_verses

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

end
