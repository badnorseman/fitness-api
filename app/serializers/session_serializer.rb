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

  def email
    Identity.where(id: object.uid).pluck(:email).first
  end

  def avatar
    object.avatar.url(:small)
  end
end
