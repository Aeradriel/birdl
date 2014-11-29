FactoryGirl.define do
  factory :face_to_face, class: FaceToFace do
    name 'Café'
    min_slots 2
    max_slots 2
    date 3.days.from_now
  end

  factory :group_event, class: OnlineChat do
    name 'Chat en ligne'
    min_slots 2
    max_slots 2
    date 1.days.from_now
  end

  factory :tourism_tour, class: TourismTour do
    name 'Visite de la Tour Eiffel'
    min_slots 4
    max_slots 10
    date 27.days.from_now
  end
end