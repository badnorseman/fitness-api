class UserSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :provider,
             :uid,
             :first_name,
             :last_name,
             :roles

  def pundit_user
    scope
  end
end
