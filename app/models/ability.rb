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
      can :add_to_cart, Product
      can :destroy, Cart, user_id: user.id
    else
      can :read, :all
    end
  end

end
