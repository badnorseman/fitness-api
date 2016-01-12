class CustomerPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.administrator?
        scope.all
      else
        raise Pundit::NotAuthorizedError, "You must log in."
      end
    end
  end

  def create?
    user.administrator?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
