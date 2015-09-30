class UserSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :email,
             :administrator,
             :coach,
             :name,
             :gender,
             :birth_date,
             :avatar,
             :can_update,
             :can_delete

  def avatar
    object.avatar.url(:small)
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
