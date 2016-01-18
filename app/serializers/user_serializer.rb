class UserSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :administrator,
             :coach,
             :name,
             :email,
             :gender,
             :birth_date,
             :avatar,
             :products,
             :can_update,
             :can_delete

  def avatar
    object.avatar.url(:normal)
  end

  def products
    object.transactions.select(:product_name)
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
