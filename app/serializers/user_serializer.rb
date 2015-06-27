class UserSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :name,
             :email,
             :administrator,
             :coach

  def pundit_user
    scope
  end
end
