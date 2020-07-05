class VerificationsController < ApplicationController
  def prescription
    @prescription = Prescription.find_by(id: params[:prescription_id])
  end
end
