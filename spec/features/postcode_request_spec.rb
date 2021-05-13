RSpec.describe "Postcode checking", type: :feature do
  scenario "User visits the home page" do
    visit "/"
    expect(page).to have_text("Welcome")
  end
end
