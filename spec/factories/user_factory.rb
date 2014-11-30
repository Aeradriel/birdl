FactoryGirl.define do
  factory :user, class: User do
    first_name 'Thibaut'
    last_name 'Roche'
    sequence(:email) { |n| "thibaut.roche.perso#{n}@gmail.com" }
    password 'password'
    password_confirmation 'password'
    confirmed_at 2.weeks.ago
    birthdate 20.years.ago
    gender 1
  end

  factory :admin, class: User do
    first_name 'Thibaut'
    last_name 'Roche'
    sequence(:email) { |n| "thibaut.roche#{n}@epitech.eu" }
    password 'password'
    password_confirmation 'password'
    confirmed_at 2.weeks.ago
    birthdate 20.years.ago
    gender 1
    admin true
  end
end
