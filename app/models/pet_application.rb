class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  validates_presence_of :pet_id, :application_id

  scope :all_pets_by_application_id,          -> (app_id) { where(application_id: app_id) }
  scope :all_pets_approved_by_application_id, -> (app_id) { where(application_id: app_id, status: "Approved") }
  scope :all_pets_rejected_by_application_id, -> (app_id) { where(application_id: app_id, status: "Rejected") }
  scope :all_pets_approved_or_rejected,       -> (app_id) { where(application_id: app_id, status: ["Approved", "Rejected"]) }

  def self.all_approved?(app_id)
    all_pets_by_application_id(app_id).count == all_pets_approved_by_application_id(app_id).count
    # return true or false. This can be used in the controller to determine if application status needs updating
  end

  # only return true if all pets have been processed and one or more are rejected
  def self.rejected_application?(app_id)
    # checks count of pets preocessed against total count
    # require 'pry'; binding.pry
    if all_pets_approved_or_rejected(app_id).count == all_pets_by_application_id(app_id).count
      # if all pets have been processed, looks for any rejected pets
     all_pets_rejected_by_application_id(app_id).count >= 1
    end
  end
end