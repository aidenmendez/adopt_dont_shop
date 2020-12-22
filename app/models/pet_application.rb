class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  validates_presence_of :pet_id, :application_id

  scope :all_pets_by_application_id, -> (app_id) { where(application_id: app_id) }
  scope :all_pets_approved_by_application_id, -> (app_id) { where(application_id: app_id, status: "Approved") }

  def self.all_approved?(app_id)
    all_pets_by_application_id(app_id).count == all_pets_approved_by_application_id(app_id).count
    # return true or false. This can be used in the controller to determine if application status needs updating
  end
end