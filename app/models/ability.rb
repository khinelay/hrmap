class Ability
  include CanCan::Ability

  def initialize(admin_user)
    if admin_user.super_admin?
      can :manage, :all
    else
      can :read, ActiveAdmin::Page, name: "Dashboard"
      can [:read, :update], AdminUser, id: admin_user.id
      can :manage, User
    end
  end
end
