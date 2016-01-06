class IdentityPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.administrator?
        scope.all
      elsif user.uid
        scope.where(id: user.uid)
      else
        raise Pundit::NotAuthorizedError, "You must log in."
      end
    end
  end

  def update?
    puts ">>>>> POLICY"
    puts record.inspect
    puts user.uid
    puts record.id
    puts "<<<<< POLICY"
    user.administrator? || (user.uid == record.id) || user.uid
  end
end
