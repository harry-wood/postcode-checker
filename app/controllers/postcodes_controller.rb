# Postcode actions
class PostcodesController < ActionController::Base
  before_action :validate_postcode, only: "check"

  def home; end

  def check
    @postcode = params["postcode"]
    @servable = ServiceArea.servable?(@postcode)
  rescue PostcodesIoClient::Error
    render "service_error"
  end

  private

  POSTCODE_REGEXP = /^(([A-Z]{1,2}\d[A-Z\d]?|ASCN|STHL|TDCU|BBND|[BFS]IQQ|PCRN|TKCA) ?\d[A-Z]{2}|BFPO ?\d{1,4}|(KY\d|MSR|VG|AI)[ -]?\d{4}|[A-Z]{2} ?\d{2}|GE ?CX|GIR ?0A{2}|SAN ?TA1)$/i.freeze

  def validate_postcode
    return if POSTCODE_REGEXP.match(params["postcode"])

    flash.now[:alert] = "Bad postcode format"
    render action: "home"
  end
end
