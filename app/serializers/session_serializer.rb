class SessionSerializer < ActiveModel::Serializer
  attributes :id,
             :email,
             :avatar,
             :gender,
             :birth_date,
             :name,
             :administrator,
             :coach,
             :token

  def avatar
    object.avatar.url(:small)
  end
end
