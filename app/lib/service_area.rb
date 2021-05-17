# Provide the servable? method in which we apply our specific criteria for
# deciding whether the postcode is servable.
module ServiceArea
  module_function

  SERVABLE_LSOA_PREFIXES_FILE = Rails.root.join("config", "servable_lsoa_prefixes.txt")

  def servable?(postcode)
    return true if PostcodeAllowedList.allowed?(postcode)

    lsoa = lsoa_for_postcode(postcode)
    return false unless lsoa

    servable_lsoa_prefixes.map { |prefix| lsoa.starts_with?(prefix) }.any?
  end

  def lsoa_for_postcode(postcode)
    postcodes_io_client.postcode_data(postcode)["lsoa"]
  end

  def postcodes_io_client
    @postcodes_io_client ||= PostcodesIoClient.new
  end

  def servable_lsoa_prefixes
    @servable_lsoa_prefixes ||=
      File.readlines(SERVABLE_LSOA_PREFIXES_FILE).map(&:strip).reject(&:empty?)
  end
end
