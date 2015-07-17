# Replace delimiter and separator with :locale and I18n configuration.
# See http://guides.rubyonrails.org/i18n.html for details.
# Rails Casts video http://railscasts.com/episodes/138-i18n.
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
    helpers.number_with_delimiter(object.amount, delimiter: delimiter, separator: separator)
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

  def delimiter
    object.currency == "USD" ? "." : ","
  end

  def separator
    object.currency == "USD" ? "," : "."
  end

  def helpers
    ActionController::Base.helpers
  end
end
