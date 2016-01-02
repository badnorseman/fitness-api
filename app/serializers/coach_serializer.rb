class CoachSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :email,
             :administrator,
             :coach,
             :name,
             :gender,
             :avatar,
             :products

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
