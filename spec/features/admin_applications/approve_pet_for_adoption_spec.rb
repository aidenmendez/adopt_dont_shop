require 'rails_helper'

RSpec.describe "As a user" do
  describe "when I visit an admin application show page" do
    before :each do
      @shelter = FactoryBot.create(:shelter)
      @pet1 = FactoryBot.create(:pet)
      @application = FactoryBot.create(:application)
  
      PetApplication.create(application_id: @application.id, pet_id: @pet1.id)
    end
    
    it "has an approve button for each pet on an application" do
      visit "/admin/applications/#{@application.id}"

      expect(page).to have_content("Admin Account")
      expect(page).to have_content("Application #{@application.id}")

      within("#pet-#{ @pet1.id }") do
        expect(page).to have_content(@pet1.name)
        expect(page).to have_button("Approve")
      end
    end
    
    it "can approve a pet on an application" do
      visit "/admin/applications/#{@application.id}"

      within("#pet-#{@pet1.id}") do
        click_button("Approve")
      end

      expect(current_path).to eq("/admin/applications/#{ @application.id }")

      within("#pet-#{@pet1.id}") do
        expect(page).to have_content(@pet1.name)
        expect(page).to have_content("Approved")
      end
    end
  end
end