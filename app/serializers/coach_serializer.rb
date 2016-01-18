class CoachSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :name,
             :email,
             :gender,
             :avatar,
             :products,
             :can_update,
             :can_delete

  def avatar
    object.avatar.url(:normal)
  end

  def products
    object.products.select(:id)
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
