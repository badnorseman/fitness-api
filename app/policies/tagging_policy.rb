class TaggingPolicy < ApplicationPolicy

  def create?
    user.administrator? || user.coach?
  end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      if user.administrator?
        scope.all
      elsif user.coach?
        scope.all
      else
        raise Pundit::NotAuthorizedError, "You are not authenticated."
      end
    end
  end
end
