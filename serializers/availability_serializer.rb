class AvailabilitySerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :start_at,
             :end_at,
             :opening_time,
             :closing_time,
             :duration,
             :auto_confirmation,
             :permitted_weekdays,
             :cancellation_period,
             :late_cancellation_fee,
             :maximum_of_participants,
             :priority,
             :can_update,
             :can_delete

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
