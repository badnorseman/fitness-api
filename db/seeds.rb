# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
identity = Identity.create(
    email: "agent.smith@matrix.com",
    password: "dammit"
  )
user = User.create(
    uid: identity.id,
    provider: "identity",
    first_name: "Agent",
    last_name: "Smith",
    roles: ["user", "coach", "administrator"]
  )
