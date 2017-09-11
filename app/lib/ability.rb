class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :manage, user if user.confirmed?
      can :manage, Account, user_id: user.id
      can :read, Hero
    end
  end
end
