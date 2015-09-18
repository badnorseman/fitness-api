class SessionSerializer < ActiveModel::Serializer
  attributes :id,
             :email,
             :name,
             :avatar,
             :administrator,
             :coach,
             :token

  def avatar
    object.avatar.url(:small)
  end
end
