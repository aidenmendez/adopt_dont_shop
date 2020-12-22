class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state,presence: true
  validates :zip_code, presence: true
  validates :status, presence: true

  def adoption_status(pet_id)
    pet_app = PetApplication.find_by(pet_id: pet_id, application_id: id)
    pet_app.status
  end

  def update_status(new_status)
    update(status: new_status)
  end
end