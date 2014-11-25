# Temp controller for api
class ApiController < ApplicationController
  def check_email
    if User.where(email: params[:email]).first.nil?
      render text: 'OK'
    else
      render text: 'KO'
    end
  end
end
