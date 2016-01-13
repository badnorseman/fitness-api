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
             :identity_id,
             :identity_email

  def avatar
    object.avatar.url(:small)
  end

  def products
    object.transactions.select(:product_id)
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
