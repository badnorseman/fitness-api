class BookingSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :start_at,
             :end_at,
             :canceled_at,
             :canceled_by,
             :confirmed_at,
             :coach_id,
             :coach_name,
             :user_name,
             :can_update,
             :can_delete

  def coach_name
    object.coach.name || object.coach.email
  end

  def user_name
    object.user.name || object.user.email
  end

  def can_update
    policy(object).update?
  end

  def can_delete
    policy(object).destroy?
  end

  def pundit_user
    scope
  end
end
