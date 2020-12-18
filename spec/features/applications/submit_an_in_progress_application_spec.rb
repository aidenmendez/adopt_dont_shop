require 'rails_helper'

RSpec.describe "As a user" do
  describe "when I visit a show page for an application with pets" do
    before :each do
      @shelter1 = FactoryBot.create(:shelter)
      @pet1 = FactoryBot.create(:pet)
      @pet2 = FactoryBot.create(:pet)
      @application = FactoryBot.create(:application)
      PetApplication.create(application: @application, pet: @pet1)
      PetApplication.create(application: @application, pet: @pet2)
    end

    it "should have a section for submitting the application" do
      visit "/applications/#{@application.id}"

      expect(page).to have_content("Add a Pet to this Application")
      
      within("#description-section") do
        expect(page).to have_content("Why would you be a good home?")
        fill_in("description", :with => "I have a large house and am home most of the time.")
        click_button "Submit Application"
      end
      
      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content(@application.description)

      expect(page).to have_content("Application Status: Pending")

      expect(page).to have_link(@pet1.name, href: "/pets/#{@pet1.id}")
      expect(page).to have_link(@pet2.name, href: "/pets/#{@pet2.id}")

      expect(page).not_to have_content("Add a Pet to this Application")
    end

    it "can't submit form without a description" do
      visit "/applications/#{@application.id}"
      
      click_button "Submit Application"

      expect(page).to have_content("Invalid description. Try again.")
    end
  end
end