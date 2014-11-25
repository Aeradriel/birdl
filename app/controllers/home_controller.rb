# Controller for HomePage
class HomeController < ApplicationController
  def index
    @modules_to_display = [:achievements, :messages]
    @achievements = current_user.achievements
    @sent_messages = current_user.sent_messages[0..1]
    @received_messages = current_user.received_messages[0..1]
    @event = current_user.events.order(:date).first
    @modules_to_display << :events if @event
  end
end
