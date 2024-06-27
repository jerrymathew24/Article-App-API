class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    elsif user.editor?
      can :read, :all
      can :create, Article
      can :update, Article
    elsif user.user?
      can :read, :all
      can :create, Article
    else
      can :read, :all
    end
  end
end
