require 'rails_helper'

RSpec.describe "As a user" do
  before(:all) do
    @shelter = FactoryBot.create(:shelter)
    @pet1 = FactoryBot.create(:pet)
    @application1 = FactoryBot.create(:application)
    @application2 = FactoryBot.create(:application)

    PetApplication.create!(application_id: @application1.id, pet_id: @pet1.id)
    PetApplication.create!(application_id: @application2.id, pet_id: @pet1.id)
  end

  describe "when I am approving applications" do
    it "a pet can only be approved on a single application" do
      visit "/admin/applications/#{@application1.id}"
      
      within("#pet-#{@pet1.id}") do
        click_button("Approve")
      end

      visit "/admin/applications/#{@application1.id}"

      expect(page).to have_content("Approved")

      visit "/admin/applications/#{@application2.id}"

      within("#pet-#{@pet1.id}") do
        save_and_open_page
        expect(page).to have_content("This pet has already found a home.")
        expect(page).to have_button("Reject")
        expect(page).not_to have_content("Approve")
      end
    end
  end
end

    # describe "and I visit the admin application show page for a pending application" do
    #   it "there is a message that the pet has already been approved for adoption and there is a only an option to reject it" do
    #     visit "/admin/applications/#{@application2.id}"

    #     within("#pet-#{@pet1.id}") do
    #       expect(page).to have_content("This pet has already found a home.")
    #       expect(page).to have_content("Reject")
    #       expect(page).not_to have_content("Approve")
    #     end
  #     end
  #   end
  # end
