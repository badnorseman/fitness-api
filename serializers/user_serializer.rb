class UserSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :uid,
             :name,
             :email,
             :roles

  def pundit_user
    scope
  end
end
