class ApplicationPolicy < NaturalResource::Policy
  class Scope < Scope
    # It is recommended to use per-role scopes for Users # simply extend the
    # resolve method with conditions for each "role" and the name of the scope
    # they should call.
    def resolve
      if !user.is_a? User
        anon_user_scope
      elsif user.admin?
        admin_user_scope
      else
        standard_user_scope
      end
    end

    def admin_user_scope
      scope
    end

    def standard_user_scope
      scope.where(user: user)
    end

    def anon_user_scope
      raise NotImplementedError, [self.class.name, __method__].join('#')
    end
  end
end
