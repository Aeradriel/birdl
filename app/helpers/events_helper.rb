# Helpers for events module
module EventsHelper
  def event_route(e)
    return "/events/facestofaces/#{e.id}" if e.is_a? FaceToFace
    return "/events/groupevents/#{e.id}" if e.is_a? GroupEvent
    '/events/' if e.is_a? TourismTour
  end

  def can_register?(e, u)
    return false if e.users.include?(u)
    return false if e.max_slots == e.users.count
    true
  end
end
