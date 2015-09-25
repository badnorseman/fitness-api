class SessionSerializer < ActiveModel::Serializer
  attributes :id,
             :email,
             :avatar,
             :gender,
             :birth_date,
             :height,
             :name,
             :weight,
             :administrator,
             :coach,
             :token

  def avatar
    object.avatar.url(:small)
  end
end
