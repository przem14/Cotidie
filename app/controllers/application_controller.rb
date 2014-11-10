class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  attr_reader :language

  def initialize
    require File.expand_path('../../../lib/languages/polish_language_pack', __FILE__)
    @language = PolishLanguagePack.new
  end

protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :role << :name << :surname << :personal_id
    devise_parameter_sanitizer.for(:account_update) << :name << :surname
  end
end
