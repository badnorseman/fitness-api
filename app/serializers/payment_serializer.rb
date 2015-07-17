class PaymentSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :amount,
             :currency,
             :product_id,
             :transaction_date,
             :transaction_id,
             :can_update,
             :can_delete

  def amount
    object.amount
  end

  def transaction_date
    object.created_at.to_formatted_s(:long_ordinal)
  end

  def can_update
    policy(object).update?
  end

  def can_delete
    policy(object).destroy?
  end

  def pundit_user
    scope
  end
end
