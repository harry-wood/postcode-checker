RSpec.describe "Postcode checking", type: :feature do
  scenario "User visits the home page" do
    visit "/"
    expect(page).to have_text("Enter a postcode")
  end

  scenario "User enters a valid postcode" do
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
end
