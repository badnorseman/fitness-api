class CoachSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :name,
             :email,
             :gender,
             :avatar,
             :products

  def avatar
    object.avatar.url(:small)
  end

  def products
    object.products.select(:id)
  end

  def pundit_user
    scope
  end
end
