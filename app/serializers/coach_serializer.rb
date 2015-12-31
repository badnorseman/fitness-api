class CoachSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :email,
             :administrator,
             :coach,
             :name,
             :gender,
             :avatar,
             :product_ids

  def product_ids
    object.products.map(&:id)
  end

  def avatar
    object.avatar.url(:small)
  end

  def pundit_user
    scope
  end
end
