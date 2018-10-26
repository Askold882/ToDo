# require 'faker'

# FactoryGirl.define do
  
#   factory :user do
#     name Faker::Name.name
#     secondname Faker::Name.name
#     email Faker::Internet.email
#     password Faker::Internet.password
#   end

#   factory :task do
#     context Faker::Name.name
#     duedate Faker::Time.between(2.days.ago, Time.now)
#     priority Faker::Number.number(2)
#     done "false"
#     title Faker::Name.name
#   end
# end