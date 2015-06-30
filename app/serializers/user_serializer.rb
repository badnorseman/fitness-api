class UserSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :email,
             :name,
             :gender,
             :birth_date,
             :height,
             :weight,
             :administrator,
             :coach

  def pundit_user
    scope
  end
end
