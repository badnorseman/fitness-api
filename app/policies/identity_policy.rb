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

  def update?
    puts ">>>>> POLICY"
    puts user.inspect
    puts record.inspect
    user.administrator? || user.uid == record.id
    puts user.present?
    puts "<<<<< POLICY"
    true
  end
end
