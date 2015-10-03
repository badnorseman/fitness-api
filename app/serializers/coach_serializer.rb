class CoachSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :email,
             :administrator,
             :coach,
             :name,
             :gender,
             :avatar

  def avatar
    object.avatar.url(:small)
  end

  def pundit_user
    scope
  end
end
