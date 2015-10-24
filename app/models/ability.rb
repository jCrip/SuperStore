class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(role: 2)
    if user.admin?
      can :manage, :all
    elsif user.client?
      can :read, :all
      can :create, Review
      can [:update, :destroy], Review, user_id: user.id
      can :like, [Product, Review]
    else
      can :read, :all
    end
  end

end
