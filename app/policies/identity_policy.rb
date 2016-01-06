class IdentityPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.administrator?
        scope.all
      elsif user.present?
        puts ">>>>> SCOPE"
        puts user.inspect
        puts record.inspect
        puts scope.where(id: user.uid)
        scope.where(id: user.uid)
        puts "<<<<< SCOPE"
      else
        raise Pundit::NotAuthorizedError, "You must log in."
      end
    end
  end

  def show?
    puts ">>>>> POLICY"
    puts user.inspect
    puts record.inspect
    user.administrator? || user.uid == record.id
    puts "<<<<< POLICY"
  end

  def create?
    show?
  end

  def update?
    show?
  end
end
