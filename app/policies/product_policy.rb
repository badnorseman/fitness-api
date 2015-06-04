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
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
