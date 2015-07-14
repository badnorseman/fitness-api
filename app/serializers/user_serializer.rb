class UserSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :email,
             :name,
             :gender,
             :birth_date,
             :height,
             :weight,
             :avatar

  def avatar
    object.avatar.url(:small)
  end

  def pundit_user
    scope
  end
end
