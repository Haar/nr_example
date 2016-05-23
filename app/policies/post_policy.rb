class PostPolicy < ApplicationPolicy
  def create?
    user?
  end

  def edit?
    author? || admin?
  end

  def query?
    admin?
  end

  def author?
    user? && record.user == user
  end

  class Scope < Scope
    # See ApplicationPolicy.rb to see how a scope is defined and used
  end
end
