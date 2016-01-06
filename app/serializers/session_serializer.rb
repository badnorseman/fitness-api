class SessionSerializer < ActiveModel::Serializer
  attributes :id,
             :uid,
             :token,
             :email,
             :administrator,
             :coach,
             :name,
             :gender,
             :birth_date,
             :avatar

  def avatar
    object.avatar.url(:small)
  end
end
