class LocationPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.administrator?
        scope.all
      else
        raise Pundit::NotAuthorizedError, "You must log in."
      end
    end
  end

  def show?
    user.administrator? || user.id == record.id
  end

  def create?
    user.id?
  end

  def update?
    show?
  end

  def destroy?
    user.administrator?
  end
end
