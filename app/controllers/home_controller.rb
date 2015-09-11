# Controller for HomePage
class HomeController < ApplicationController
  def index
    @modules_to_display = modules_to_display
    @achievements = current_user.achievements
    @sent_messages = current_user.sent_messages.order(created_at: :desc)[0..1]
    @received_messages = current_user.received_messages.order(created_at: :desc)[0..1]
    @event = current_user.events.order(:date).first
  end

  private

  def modules_to_display
    scores = { achievements: 3, messages: 5, event: 4 }
    scores[:messages] = 10 if @current_user.received_messages.unread.count > 0
    scores[:events] = 9 if @current_user.events.soon.count > 0
    scores[:achievements] = 6 if @current_user.achievements.recent.count > 0
    Hash[scores.sort_by { |_key, value| value }[0..2]]
  end
end
