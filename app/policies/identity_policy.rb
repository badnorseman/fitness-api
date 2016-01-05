class IdentityPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.administrator?
        scope.all
      elsif user.present?
        scope.where(id: user.uid)
      else
        raise Pundit::NotAuthorizedError, "You must log in."
      end
    end
  end

  def show?
    user.administrator? || user.id == record.id
  end

  def create?
    show?
  end

  def update?
    show?
  end
end
