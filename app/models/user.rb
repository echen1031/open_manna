class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions

  def over_subscription_limit?
    subscriptions.size >= 2
  end

  def admin?
    self.email == AdminUser.first.email
  end
end
