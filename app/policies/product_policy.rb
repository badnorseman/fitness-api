class ProductPolicy < ApplicationPolicy

  def create?
    user.administrator? || (user.coach? && user.id == record.user_id)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      if user.administrator?
        scope.all
      elsif user.coach?
        scope.where(user_id: user.id)
      else
        raise Pundit::NotAuthorizedError, "You must log in."
      end
    end
  end
end
