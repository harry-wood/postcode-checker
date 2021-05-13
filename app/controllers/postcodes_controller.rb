# Postcode actions
class PostcodesController < ActionController::Base
  def home; end

  def check
    @postcode = params["postcode"]
    @servable = true
  end
end
