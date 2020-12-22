require 'rails_helper'

RSpec.describe PetApplication do
  describe "relationships" do
    it {should belong_to :pet}
    it {should belong_to :application}
  end

  describe "validations" do
    it {is_expected.to validate_presence_of(:pet_id)}
    it {is_expected.to validate_presence_of(:application_id)}
  end

  describe "all_approved?" do
    before :each do
      @shelter = FactoryBot.create(:shelter)
      @pet1 = FactoryBot.create(:pet)
      @pet2 = FactoryBot.create(:pet)
      @application = FactoryBot.create(:application)
  
      @pet_app1 = PetApplication.create!(application_id: @application.id, pet_id: @pet1.id)
      @pet_app2 = PetApplication.create!(application_id: @application.id, pet_id: @pet2.id)
    end
    it "should compare the total number of pet count for an applicant to the count of pets with an approved status" do
      expect(PetApplication.all_approved?(@application.id)).to eq(false)

      @pet_app1.update(status: "Approved")

      expect(PetApplication.all_approved?(@application.id)).to eq(false)

      @pet_app2.update(status: "Approved")

      expect(PetApplication.all_approved?(@application.id)).to eq(true)
    end
  end
end