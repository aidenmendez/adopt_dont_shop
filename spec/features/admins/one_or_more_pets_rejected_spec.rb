require 'rails_helper'

RSpec.describe "As a user" do
  describe "when I visit an admin application show page" do
    before :each do
      @shelter = FactoryBot.create(:shelter)
      @pet1 = FactoryBot.create(:pet)
      @pet2 = FactoryBot.create(:pet)
      @pet3 = FactoryBot.create(:pet)
      @application = FactoryBot.create(:application)
  
      PetApplication.create!(application_id: @application.id, pet_id: @pet1.id)
      PetApplication.create!(application_id: @application.id, pet_id: @pet2.id)
      PetApplication.create!(application_id: @application.id, pet_id: @pet3.id)
    end

    it "And I reject one pet for the application and approve the rest" do
      visit "/admin/applications/#{@application.id}"

      within("#pet-#{ @pet1.id }") do
        click_button("Reject")
      end

      within("#pet-#{ @pet2.id }") do
        click_button("Approve")
      end
  
      within("#pet-#{ @pet3.id }") do
        click_button("Approve")
      end

      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to have_content("Application Status: Rejected")
    end

    # it "And I approve all other pets on the application" do
    #   visit "/admin/applications/#{@application.id}"
      
    # end
  end
end
