# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
admin = User.create(
  {
    uid: "admin@fitbird.com",
    name: "administrator",
    first_name: "administrator",
    last_name: "fitbird",
    provider: "email",
    email: "admin@fitbird.com",
    password: "Test1234",
    roles: ["user", "coach", "administrator"]
  })

coaches = User.create([
  {
    uid: "coach@fitbird.com",
    name: "coach",
    first_name: "coach",
    last_name: "fitbird",
    provider: "email",
    email: "coach@fitbird.com",
    password: "Test1234",
    roles: ["user", "coach"]
  }]);

users = User.create([
  {
    uid: "user@fitbird.com",
    name: "user",
    first_name: "user",
    last_name: "fitbird",
    provider: "email",
    email: "user@fitbird.com",
    password: "Test1234",
    roles: ["user"]
  }]);

roles = Role.create([
  {
    name: "Administrator", uniquable_name: "administrator"
  },
  {
    name: "Coach", uniquable_name: "coach"
  },
  {
    name: "User", uniquable_name: "user"
  }]);
