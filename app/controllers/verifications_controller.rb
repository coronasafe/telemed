class VerificationsController < ApplicationController
  def prescription
    @prescription = Prescription.find(params[:prescription_id])
  end
end
