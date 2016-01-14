# Replace delimiter and separator with :locale and I18n configuration.
# See http://guides.rubyonrails.org/i18n.html for details.
# Rails Casts video http://railscasts.com/episodes/138-i18n.
class TransactionSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :amount,
             :currency,
             :customer,
             :merchant,
             :product,
             :transaction_date,
             :transaction_id,
             :transaction_type,
             :can_update,
             :can_delete

  def amount
    helpers.number_with_delimiter(object.amount, delimiter: delimiter, separator: separator)
  end

  def customer
    User.exists?(object.user_id) ? object.user_id : object.customer_name
  end

  def merchant
    object.merchant_name
  end

  def product
    Product.exists?(object.product_id) ? object.product_id : object.product_name
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
