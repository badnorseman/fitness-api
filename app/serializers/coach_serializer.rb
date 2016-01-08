class CoachSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :email,
             :name,
             :gender,
             :avatar,
             :products

  def email
    Identity.where(id: object.uid).pluck(:email).first
  end

  def products
    object.products.select(:id)
  end

  def avatar
    object.avatar.url(:small)
  end

  def pundit_user
    scope
  end
end
