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

  # GET /prescriptions
  def index
    @prescriptions = Prescription.all
  end

  # GET /prescriptions/1
  def show
    @prescription = Prescription.find(params[:id])
  end

  # GET /prescriptions/1/edit
  def edit
    @prescription = Prescription.find(params[:id])
  end

  # PATCH /prescriptions/1
  def update
    @prescription = Prescription.find(params[:id])
    respond_to do |format|
      if @prescription.update!(prescription_update_params)
        format.html { redirect_to @prescription, notice: 'Prescription was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_contact
    @contact = Contact.find(params[:contact_id])
  end

  def prescription_create_params
    params.require(:prescription).permit(:source, :scheme, :supplier, :delivery_status).merge(contact_id: set_contact&.id, creator_id: current_user.id, delivery_status: 'pending')
  end

  def prescription_update_params
    params.require(:prescription).permit(:source, :scheme, :supplier, :delivery_status)
  end
end
