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

  describe "adoption status" do
    PetApplication.destroy_all
    Pet.destroy_all
    Application.destroy_all
    Shelter.destroy_all
    
    it "should return application adoption status" do
      @shelter = FactoryBot.create(:shelter)
      @pet1 = FactoryBot.create(:pet)
      @application = FactoryBot.create(:application)
      
      PetApplication.create(application: @application, pet: @pet1)

      expect(@application.adoption_status(@pet1.id)).to eq("In Progress")
    end
  end
end