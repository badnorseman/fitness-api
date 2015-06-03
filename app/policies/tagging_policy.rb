class TaggingPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.administrator?
        scope.all
      elsif user.coach?
        scope.all
      else
        raise Pundit::NotAuthorizedError, "You must log in."
      end
    end
  end

  def create?
    user.administrator? || user.coach?
  end

  def destroy?
    create?
  end
end
