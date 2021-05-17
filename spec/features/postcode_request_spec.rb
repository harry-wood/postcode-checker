RSpec.describe "Postcode checking", type: :feature do
  scenario "User visits the home page" do
    visit "/"
    expect(page).to have_text("Enter a postcode")
  end

  scenario "User enters a valid servable postcode" do
    stub_request(:get, "http://postcodes.io/postcodes/SE1%207QD")
      .to_return(body: File.read(
        "spec/dummy_data/postcodes_io_responses/servable_postcode.json"
      ))

    visit "/"
    fill_in "postcode", with: "SE1 7QD"
    click_button "Check"

    expect(page).to have_text("Results from checking postcode SE1 7QD")
    expect(page).to have_text("postcode is within our service area")
    expect(page).to have_link("Check another postcode")
  end

  scenario "User enters a non-servable postcode" do
    stub_request(:get, "http://postcodes.io/postcodes/N19%204BA")
      .to_return(body: File.read(
        "spec/dummy_data/postcodes_io_responses/non_servable_postcode.json"
      ))

    visit "/"
    fill_in "postcode", with: "N19 4BA"
    click_button "Check"

    expect(page).to have_text("postcode is not within our service area")
  end

  scenario "User enters a postcode from the allowed list" do
    visit "/"
    fill_in "postcode", with: "SH24 1AB"
    click_button "Check"

    expect(page).to have_text("postcode is within our service area")
  end
end
