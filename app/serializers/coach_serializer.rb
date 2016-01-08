class CoachSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :name,
             :gender,
             :avatar,
             :email,
             :products

  def avatar
    object.avatar.url(:small)
  end

  def email
    Identity.where(id: object.uid).pluck(:email).first
  end

  def products
    object.products.select(:id)
  end

  def pundit_user
    scope
  end
end
