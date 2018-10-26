require 'faker'

FactoryBot.define do
  factory :task do
    duedate 1.day.from_now
    priority Faker::Number.number(2)
    done "false"
    title Faker::Name.name
    description Faker::Name.name
  end
end