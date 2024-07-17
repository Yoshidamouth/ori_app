FactoryBot.define do
  factory :user do
    lastname              {'岡'}
    firstname             {'聡実'}
    email                 {Faker::Internet.email}
    password              {'aaa111'}
    password_confirmation {'aaa111'}
    affiliation_id        {'2'}
  end
end