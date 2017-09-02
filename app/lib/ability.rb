class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :manage, user if user.confirmed?
      can :read, Hero
    end
  end
end
