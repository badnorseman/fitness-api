class FailedTransactionPolicy < ApplicationPolicy

  def create?
    user.id?
  end
end
