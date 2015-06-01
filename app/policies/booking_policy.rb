class BookingPolicy < ApplicationPolicy

  def show?
    user.administrator? || (user.id == record.user_id || user.id == record.coach_id)
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

  def confirm?
    user.id == record.coach_id
  end

  class Scope < Scope
    def resolve
      if user.administrator?
        scope.all
      elsif user.id?
        scope.where("user_id = :id OR coach_id = :id", id: user.id)
      else
        raise Pundit::NotAuthorizedError, "You must log in."
      end
    end
  end
end
