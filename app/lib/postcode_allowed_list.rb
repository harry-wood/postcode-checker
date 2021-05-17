# Manage the list of postcodes which are allowed as an override either because
# they would not normally meet the service area (lsoa based) criteria, or
# because they are not known to postcodes.io
module PostcodeAllowedList
  module_function

  POSTCODE_ALLOWED_LIST_FILE = Rails.root.join("config", "postcode_allowed_list.txt")

  def allowed?(postcode)
    postcodes.include?(postcode.gsub(/\s+/, ""))
  end

  def postcodes
    @postcodes ||=
      File.readlines(POSTCODE_ALLOWED_LIST_FILE)
          .reject(&:empty?)
          .map { |postcode| postcode.gsub(/\s+/, "") }
  end
end
