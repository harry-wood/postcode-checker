# frozen_string_literal: true

# Methods for accessing the postcodes.io API
class PostcodesIoClient
  class Error < StandardError; end

  class NotFoundError < PostcodesIoClient::Error; end

  attr_accessor :client

  BASE_URL = "http://postcodes.io"

  def initialize
    @client = HTTPClient.new
  end

  def postcode_data(postcode)
    url = "#{BASE_URL}/postcodes/#{postcode}"

    Rails.logger.info "Getting #{url}"
    response = client.get(url)
    raise PostcodesIoClient::NotFoundError if response.code == 404
    raise(PostcodesIoClient::Error, "Error:#{response.code} response calling url:#{url}") unless response.code == 200

    JSON.parse(response.body).fetch("result")
  rescue Timeout::Error, SystemCallError, SocketError, EOFError, HTTPClient::BadResponseError, HTTPClient::TimeoutError => e
    raise PostcodesIoClient::Error, "Error:#{e.inspect} calling url:#{url}"
  end
end
