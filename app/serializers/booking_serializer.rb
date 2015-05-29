class BookingSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :start_at,
             :end_at,
             :canceled_at,
             :canceled_by,
             :confirmed_at,
             :coach_id,
             :coach_full_name,
             :user_full_name,
             :can_update,
             :can_delete

  def coach_full_name
    [object.coach.first_name, object.coach.last_name].join(" ") || object.coach.email
  end

  def user_full_name
    [object.user.first_name, object.user.last_name].join(" ") || object.user.email
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
