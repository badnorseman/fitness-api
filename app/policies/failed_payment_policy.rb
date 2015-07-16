class FailedPaymentPolicy < ApplicationPolicy

  def create?
    user.id?
  end
end
