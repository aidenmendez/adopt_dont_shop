PetApplication.destroy_all
Pet.destroy_all
Application.destroy_all
Shelter.destroy_all

rand(3..5).times do
  FactoryBot.create(:shelter)
end

rand(15..20).times do
  FactoryBot.create(:pet)
end

rand(10..15).times do
  application = FactoryBot.create(:application)
  pets = Pet.all.sample(rand(1..5))
  pets.each do |pet|
    PetApplication.create(application_id: application.id, pet_id: pet.id)
  end
  application.save
end

rand(10..15).times do
  application = FactoryBot.create(:application)
  pets = Pet.all.sample(rand(1..5))
  pets.each do |pet|
    PetApplication.create(application_id: application.id, pet_id: pet.id)
  end
  application.description = Faker::Lorem.sentences(number: 3).join(' ')
  application.status = "Pending"
  application.save
end

rand(5..10).times do
  application = FactoryBot.create(:application)
  pets = Pet.all.sample(rand(1..5))
  pets.each do |pet|
    PetApplication.create(application_id: application.id, pet_id: pet.id)
  end
  application.description = Faker::Lorem.sentences(number: 3).join(' ')
  application.status = "Rejected"
  application.save
end

rand(10..15).times do
  application = FactoryBot.create(:application)
  pets = Pet.all.sample(rand(1..5))
  pets.each do |pet|
    PetApplication.create(application_id: application.id, pet_id: pet.id)
  end
  application.description = Faker::Lorem.sentences(number: 3).join(' ')
  application.status = "Accepted"
  application.save
end

"In Progress", "Pending", "Accepted", or "Rejected"