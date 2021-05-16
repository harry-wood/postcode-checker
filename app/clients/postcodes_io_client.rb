# frozen_string_literal: true

# Methods for accessing the postcodes.io API
class PostcodesIoClient
  attr_accessor :client

  BASE_URL = "http://postcodes.io"

  def initialize
    @client = HTTPClient.new
  end

  def postcode_data(postcode)
    url = "#{BASE_URL}/postcodes/#{postcode}"

    Rails.logger.info "Getting #{url}"
    response = client.get(url)

    JSON.parse(response.body).fetch("result")
  end
end
