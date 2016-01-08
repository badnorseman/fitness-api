class SessionSerializer < ActiveModel::Serializer
  attributes :id,
             :token,
             :administrator,
             :coach,
             :name,
             :gender,
             :birth_date,
             :avatar,
             :email,
             :identity_id

  def avatar
    object.avatar.url(:small)
  end

  def email
    Identity.where(id: object.uid).pluck(:email).first
  end

  def identity_id
    Identity.where(id: object.uid).pluck(:id).first
  end
end
