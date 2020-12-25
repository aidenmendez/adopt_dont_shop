class PetApplicationsController < ApplicationController
  def create
    PetApplication.create!(application_id: params[:application_id], pet_id: params[:pet_id])
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    pet_app = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:application_id])

    if params[:status] == "Approved"
      pet_app.status = "Approved"
      pet_app.save
      # check if all pets have been approved
      if PetApplication.all_approved?(params[:application_id])
        # if true, update application status from "In Progress" to "Approved"
        Application.find_by(id: params[:application_id]).update_status("Approved")
      # check if pet processing is finished and if any pets were rejected
      elsif PetApplication.rejected_application?(params[:application_id])
        Application.find_by(id: params[:application_id]).update_status("Rejected")
      end
    elsif params[:status] == "Rejected"
      pet_app.status = "Rejected"
      pet_app.save

      if PetApplication.rejected_application?(params[:application_id])
        Application.find_by(id: params[:application_id]).update_status("Rejected")
      end
    end

    redirect_to params[:path]
  end

end