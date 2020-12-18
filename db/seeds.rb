# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Pet.destroy_all
Application.destroy_all
Shelter.destroy_all

@shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
@shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
@pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
@pet2 = @shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
@pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
@application1 = Application.create!(name: "Aiden Mendez", address:"1255 S Clermont St", city: "Denver", state: "CO", zip_code: "80246" )

# rand(3..5).times do
#   FactoryBot.create(:shelter)
# end

# rand(15..20).times do
#   FactoryBot.create(:pet)
# end

# rand(10..15).times do
#   application = FactoryBot.create(:application)
#   pets = Pet.all.sample(rand(1..5))
#   pets.each do |pet|
#     PetApplication.create(application_id: application.id, pet_id: pet.id)
#   end
#   application.save
# end

# rand(10..15).times do
#   application = FactoryBot.create(:application)
#   pets = Pet.all.sample(rand(1..5))
#   pets.each do |pet|
#     PetApplication.create(application_id: application.id, pet_id: pet.id)
#   end
#   application.description = Faker::Lorem.sentences(number: 3).join(' ')
#   application.status = "Pending"
#   application.save
# end

# rand(5..10).times do
#   application = FactoryBot.create(:application)
#   pets = Pet.all.sample(rand(1..5))
#   pets.each do |pet|
#     PetApplication.create(application_id: application.id, pet_id: pet.id)
#   end
#   application.description = Faker::Lorem.sentences(number: 3).join(' ')
#   application.status = "Rejected"
#   application.save
# end

# rand(10..15).times do
#   application = FactoryBot.create(:application)
#   pets = Pet.all.sample(rand(1..5))
#   pets.each do |pet|
#     PetApplication.create(application_id: application.id, pet_id: pet.id)
#   end
#   application.description = Faker::Lorem.sentences(number: 3).join(' ')
#   application.status = "Accepted"
#   application.save
# end

# "In Progress", "Pending", "Accepted", or "Rejected"