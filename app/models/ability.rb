class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_a?(Admin)
      can :manage, :all
    elsif user.is_a?(User)
      can :read, Post
    end
  end
end
