class SessionSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :email,
             :administrator,
             :coach,
             :token
end
