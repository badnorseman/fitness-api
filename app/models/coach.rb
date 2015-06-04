class Coach < User
  default_scope { where(coach: true) }
end
