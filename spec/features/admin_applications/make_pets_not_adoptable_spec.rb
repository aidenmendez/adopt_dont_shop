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

    it "and I approve an application, those pets are no longer adoptable" do
      visit "/admin/applications/#{@application.id}"

      within("#pet-#{@pet1.id}") do
        click_button("Approve")
      end

      within("#pet-#{@pet2.id}") do
        click_button("Approve")
      end

      within("#pet-#{@pet3.id}") do
        click_button("Approve")
      end

      expect(current_path).to eq("/admin/applications/#{@application.id}")
  
      visit "/pets/#{@pet1.id}"
      expect(page).to have_content("Adoption Status: false")
  
      visit "/pets/#{@pet2.id}"
      expect(page).to have_content("Adoption Status: false")
  
      visit "/pets/#{@pet3.id}"
      expect(page).to have_content("Adoption Status: false")
    end
  end
end
