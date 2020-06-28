class PrescriptionsController < ApplicationController
  def create
    @prescription = Prescription.new(prescription_create_params)
    respond_to do |format|
      if set_contact.present? && @prescription.save!
        format.html { redirect_to @prescription, notice: "Request was Added Successfully" }
      else
        flash.now[:alert] = "There was an error saving the Prescription, Contact Your Admin"
        format.html { render :new, @prescription }
      end
    end
  end

  def new
    set_contact
    @prescription = Prescription.new
  end

  def index
  end

  def show
    @prescription = Prescription.find(params[:id])
  end

  private

  def set_contact
    @contact = Contact.find(params[:contact_id])
  end

  def prescription_create_params
    params.require(:prescription).permit(:source, :scheme, :supplier, :delivery_status).merge(contact_id: set_contact&.id, creator_id: current_user.id)
  end
end
