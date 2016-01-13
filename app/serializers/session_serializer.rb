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
             :login

  def avatar
    object.avatar.url(:small)
  end

  def login
    Identity.where(id: object.uid).select(:id, :email).first.as_json rescue nil
  end
end
