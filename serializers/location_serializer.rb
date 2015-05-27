class LocationSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :company,
             :address_line1,
             :address_line2,
             :postal_code,
             :city,
             :state_province,
             :country,
             :phone_number,
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
