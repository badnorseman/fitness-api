class CoachSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :email,
             :name,
             :gender,
             :administrator,
             :coach,
             :avatar

  def avatar
    object.avatar.url(:small)
  end

  def pundit_user
    scope
  end
end
