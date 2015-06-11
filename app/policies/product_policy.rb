class ProductPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    if user.present?
      user.administrator? || (user.coach? && user.id == record.user_id)
    end
    # Remove when login is added to app
    true
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
