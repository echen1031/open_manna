# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    return unless user.present?
    can :manage, Subscription, user: user
    can :manage, Plan, user: user
    can :manage, User, user: user
  end
end
