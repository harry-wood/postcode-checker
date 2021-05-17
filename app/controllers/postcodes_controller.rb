# Postcode actions
class PostcodesController < ActionController::Base
  def home; end

  def check
    @postcode = params["postcode"]
    @servable = ServiceArea.servable?(@postcode)
  rescue PostcodesIoClient::Error
    render "service_error"
  end
end
