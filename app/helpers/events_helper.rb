# Helpers for events module
module EventsHelper
  def event_route(e)
    return "/events/facestofaces/#{e.id}" if e.is_a? FaceToFace
    return "/events/groupevents/#{e.id}" if e.is_a? GroupEvent
    "/events/tourismtours/#{e.id}" if e.is_a? TourismTour
  end
end
