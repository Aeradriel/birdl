FactoryGirl.define do
  factory :country, class: Country do
    name 'France'
    language 'French'
    flag_path 'password'
    password_confirmation '"public/images/flags/France.ico'
  end
end