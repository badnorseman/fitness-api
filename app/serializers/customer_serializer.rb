class CustomerSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :name,
             :email,
             :gender,
             :birth_date,
             :avatar

  def avatar
    object.avatar.url(:small)
  end

  def pundit_user
    scope
  end
end
