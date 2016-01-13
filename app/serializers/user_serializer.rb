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
             :identity,
             :products,
             :identity_id,
             :identity_email

  def avatar
    object.avatar.url(:small)
  end

  def identity
    Identity.where(id: object.uid).select(:id, :email)
  end

  def products
    object.transactions.select(:product_id)
  end

  def identity_id
    Identity.where(id: object.uid).pluck(:id).first rescue nil
  end

  def identity_email
    Identity.where(id: object.uid).pluck(:email).first rescue nil
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
