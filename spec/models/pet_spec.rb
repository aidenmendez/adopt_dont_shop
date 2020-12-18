require 'rails_helper'

describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to :shelter }
    it { should have_many :applications }
    it { should have_many(:applications).through(:pet_applications)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :sex}
    it {should validate_numericality_of(:approximate_age).is_greater_than_or_equal_to(0)}

    it 'is created as adoptable by default' do
      PetApplication.destroy_all
      Pet.destroy_all
      Application.destroy_all
      Shelter.destroy_all

      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(true)
    end

    it 'can be created as not adoptable' do
      PetApplication.destroy_all
      Pet.destroy_all
      Application.destroy_all
      Shelter.destroy_all

      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(adoptable: false, name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(false)
    end

    it 'can be male' do
      PetApplication.destroy_all
      Pet.destroy_all
      Application.destroy_all
      Shelter.destroy_all

      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :male, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('male')
      expect(pet.male?).to be(true)
      expect(pet.female?).to be(false)
    end

    it 'can be female' do
      PetApplication.destroy_all
      Pet.destroy_all
      Application.destroy_all
      Shelter.destroy_all

      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('female')
      expect(pet.female?).to be(true)
      expect(pet.male?).to be(false)
    end
  end

  describe 'search' do
    PetApplication.destroy_all
    Pet.destroy_all
    Application.destroy_all
    Shelter.destroy_all

    shelter = FactoryBot.create(:shelter)
    pet1 = FactoryBot.create(:pet)
    pet2 = FactoryBot.create(:pet)

    it "can search existing pets" do
      expect(Pet.search_pets(pet1.name)).to eq([pet1])
      expect(Pet.search_pets(pet2.name)).to eq([pet2])
    end

    it "returns all pets when there is no search parameter" do
      expect(Pet.search_pets(nil)).to eq(Pet.all)
    end
    
    it "returns nil when there is no pet matching the search parameter" do
      expect(Pet.search_pets("12345")).to eq(nil)
    end
    
    it "returns all pets when nothing is entered" do
      expect(Pet.search_pets("")).to eq(Pet.all)
    end

    it "returns all pets when search_pets param is false" do
      expect(Pet.search_pets(false)).to eq(Pet.all)
    end
  end
end
