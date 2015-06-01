class TagPolicy < ApplicationPolicy

  def show?
    user.administrator? || user.coach?
  end

  def create?
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
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
