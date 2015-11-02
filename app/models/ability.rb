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
      can :show, Cart
      can :destroy, Cart, user_id: user.id
      can :create_order, Order
      can :paid_order, Order, user_id: user.id
      can :cancel_order, Order, user_id: user.id
      cannot :read, Order do |order|
        order.try(:user) != user
      end
    else
      can :read, :all
      cannot :manage, Cart
      cannot :manage, Order
    end
  end

end
