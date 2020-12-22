require 'rails_helper'

RSpec.describe "As a user" do
  describe "when I visit an admin application show page" do
    before :each do
      @shelter = FactoryBot.create(:shelter)
      @pet1 = FactoryBot.create(:pet)
      @pet2 = FactoryBot.create(:pet)
      @application = FactoryBot.create(:application)
  
      PetApplication.create!(application_id: @application.id, pet_id: @pet1.id)
      PetApplication.create!(application_id: @application.id, pet_id: @pet2.id)
    end
    
    it "and I approve all pets for adoption" do
      visit "/admin/applications/#{@application.id}"

      expect(page).to have_content("Admin Account")
      expect(page).to have_content("Application #{@application.id}")

      within("#pet-#{ @pet1.id }") do
        expect(page).to have_content(@pet1.name)
        click_button("Approve")
      end

      expect(current_path).to eq("/admin/applications/#{@application.id}")
      within("#pet-#{ @pet2.id }") do
        expect(page).to have_content(@pet2.name)
        click_button("Approve")
      end
      
      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to have_content("Application Status: Approved")
    end


    
    it "can approve a pet on an application" do
      visit "/admin/applications/#{@application.id}"

      within("#pet-#{@pet1.id}") do
        click_button("Approve")
      end

      expect(current_path).to eq("/admin/applications/#{@application.id}")

      within("#pet-#{@pet1.id}") do
        expect(page).to have_content(@pet1.name)
        expect(page).to have_content("Approved")
      end
    end
  end
end