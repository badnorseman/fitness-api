class SessionSerializer < ActiveModel::Serializer
  attributes :id,
             :token,
             :administrator,
             :coach,
             :name,
             :email,
             :gender,
             :birth_date,
             :avatar,
             :identity_id,
             :identity_email

  def avatar
    object.avatar.url(:small)
  end

  def identity_id
    Identity.where(id: object.uid).pluck(:id).first rescue nil
  end

  def identity_email
    Identity.where(id: object.uid).pluck(:email).first rescue nil
  end
end
