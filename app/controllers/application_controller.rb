class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Additional Params Permission
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
    end
    def contentful
      @client ||= Contentful::Client.new(
        access_token: ENV['CONTENTFUL_ACCESS_TOKEN'],
        space: ENV['CONTENTFUL_SPACE_ID'],
        dynamic_entries: :auto,
        raise_errors: true
      )
    end
end
