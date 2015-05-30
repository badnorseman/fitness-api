class RolePolicy < ApplicationPolicy

  def show?
    user.administrator?
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
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end
end
