class SessionSerializer < ActiveModel::Serializer
  attributes :id,
             :token,
             :email,
             :administrator,
             :coach,
             :name,
             :gender,
             :birth_date,
             :avatar

  def avatar
    object.avatar.url(:small) if object.avatar.exists?
  end
end
