class IdentityPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.administrator?
        scope.all
      elsif user.uid
        scope.where(id: user.uid)
      else
        raise Pundit::NotAuthorizedError, "You must log in."
      end
    end
  end

  def update?
    user.administrator? || (user.uid == record.id)
  end
end
