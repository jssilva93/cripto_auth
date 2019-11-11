class Api::Mobile::ApiMobileApplicationController < ApplicationController
  #include DetailedLogging
  before_action :set_locale#, :current_session, :current_user
  skip_before_action :verify_authenticity_token

  def current_session
    @passenger_session ||= Session.where(session_token: params[:t]).first
    @passenger_session
  end
  def current_customer
    @passenger ||= current_session.user
    @passenger
  end



  def set_locale
    Time.zone = "America/Bogota"
    I18n.locale = :es
  end
end
