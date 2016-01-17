class ProductSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :name,
             :description,
             :currency,
             :price,
             :image,
             :coach_id,
             :can_update,
             :can_delete

  def image
    object.image.url(:normal)
  end

  def coach_id
    object.user_id
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
