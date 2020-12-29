require 'rails_helper'

RSpec.describe "As a user," do
  describe "when I visit the admin shelter index" do
    before :each do
      @shelter1 = FactoryBot.create(:shelter, name: "Paws Welfare League")
      @shelter2 = FactoryBot.create(:shelter, name: "Creature Comforts")
      @shelter3 = FactoryBot.create(:shelter, name: "A New Hope Pet Rescue")
      @shelter4 = FactoryBot.create(:shelter, name: "Beaks and Whiskers")
    end
    it "then I see all Shelters in the system listed in reverse alphabetical order by name" do
      visit "/admin/shelters"

      expect(@shelter3).to appear_before(@shelter4)
      expect(@shelter4).to appear_before(@shelter2)
      expect(@shelter2).to appear_before(@shelter1)
    end
  end
end