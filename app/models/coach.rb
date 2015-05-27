class Coach < User
  default_scope { where("roles @> ?", "{coach}") }
end
