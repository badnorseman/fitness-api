class BookingPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.administrator?
        scope.all
      elsif user.id?
        scope.where("coach_id = :id OR user_id = :id", id: user.id)
      else
        raise Pundit::NotAuthorizedError, "You must log in."
      end
    end
  end

  def show?
    user.administrator? || user.id == record.coach_id || user.id == record.user_id
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
end
