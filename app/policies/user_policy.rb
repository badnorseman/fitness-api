class UserPolicy < ApplicationPolicy

  def show?
    user.administrator? || user.id == record.id
  end

  def create?
    user.administrator?
  end

  def update?
    show?
  end

  def destroy?
    create?
  end

  def schedule?
    user.id?
  end

  class Scope < Scope
    def resolve
      if user.administrator?
        scope.all
      elsif user.present?
        scope.where(id: user.id)
      else
        raise Pundit::NotAuthorizedError, "You must log in."
      end
    end
  end
end
