class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  attr_reader :language
  def initialize
    require File.expand_path('../../../lib/languages/polish_language_pack', __FILE__)
    @language = PolishLanguagePack.new
  end
end
