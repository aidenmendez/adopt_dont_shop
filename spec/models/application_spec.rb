require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "relationships" do
    it {should have_many :pet_applications}
    it {should have_many(:pets).through(:pet_applications)}
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:city)}
    it { is_expected.to validate_presence_of(:state)}
    it { is_expected.to validate_presence_of(:zip_code)}
  end

  describe "adoption_status" do
    before :each do
      @shelter = FactoryBot.create(:shelter)
      @pet1 = FactoryBot.create(:pet)
      @application = FactoryBot.create(:application)
  
      @pet_app = PetApplication.create!(application_id: @application.id, pet_id: @pet1.id)
    end

    it "should return adoption status for a PetApplication record" do
      expect(@application.adoption_status(@pet1.id)).to eq(@pet_app.status)
    end
  end

  describe "update_status" do
    before :each do
      # @shelter = FactoryBot.create(:shelter)
      # @pet1 = FactoryBot.create(:pet)
      @application = FactoryBot.create(:application)
  
      # @pet_app = PetApplication.create!(application_id: @application.id, pet_id: @pet1.id)
    end

    it "should update an Application's status" do
      @application.update_status("Approved")
      expect(@application.status).to eq("Approved")

      @application.update_status("Rejected")
      expect(@application.status).to eq("Rejected")
    end
  end
end