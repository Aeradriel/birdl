FactoryGirl.define do
  factory :country, class: Country do
    sequence(:name) { |n| "France #{n}" }
    sequence(:language) { |n| "Français #{n}" }
    flag_path ''
  end

  factory :france, class: Country do
    name 'France'
    language 'French'
    flag_path 'public/images/flags/flag.png'
  end

  factory :england, class: Country do
    name 'England'
    language 'English (GB)'
    flag_path 'public/images/flags/flag.png'
  end

  factory :usa, class: Country do
    name 'USA'
    language 'English (US)'
    flag_path 'public/images/flags/flag.png'
  end

  factory :canada, class: Country do
    name 'Canada'
    language 'Nawak'
    flag_path 'public/images/flags/flag.png'
  end
end
