# Class model for faces to faces
class FaceToFace < Event
  validates_presence_of :address
  validates_presence_of :location
  validates_presence_of :language
end
