class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy, :make_call]

  # GET /contacts
  def index
  end

  def summary
  end

  # GET /contacts/1
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    existing_contact = Contact.find_by(phone: contact_params["phone"].squish)
    if existing_contact
      create_consultation(existing_contact)
      redirect_to existing_contact
    else
      respond_to do |format|
        if @contact.save
          create_consultation(@contact)
          format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
          format.json { render :show, status: :created, location: @contact }
        else
          flash.now[:alert] = 'Invalid mobile number'
          format.html { render :new }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update!(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def make_call
    called_user = User.find(params[:user_id])
    @contact.calls.create(user: called_user)
    respond_to do |format|
      format.html { redirect_to contacts_path, notice: "Contact #{@contact.name} was successfully Called" }
      format.json { head :no_content }
    end
  end

  def generate_medical_reqs
    unscoped_contacts = Contact.joins(:medical_reqs).where(medical_reqs: { fullfilled: nil, not_able_type: nil }).distinct
    contacts = scope_access(unscoped_contacts)
    respond_to do |format|
      format.csv { send_data contacts.to_medical_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def generate_non_medical_reqs
    unscoped_contacts = Contact.joins(:non_medical_reqs).where(non_medical_reqs: { fullfilled: nil, not_able_type: nil }).distinct
    contacts = scope_access(unscoped_contacts)
    respond_to do |format|
      format.csv { send_data contacts.to_non_medical_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def find_phone
    phone = params["search"]["phone_number"]
    @contact = Contact.find_by(phone: phone.squish)
    if @contact
      redirect_to @contact
    else
      @contact = Contact.new
      @contact.phone = phone
      render :new
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  def scope_access(contacts)
    if current_user.admin?
      consultations.all
    elsif current_user.district_admin?
      contacts
    elsif current_user.panchayat_admin?
      contacts.where(panchayat: current_user.panchayat)
    end
  end

  def create_consultation(contact)
    contact.consultations.create!(consultation_params)
  end

  def action
    Action.find_by(name: 'Pending')
  end

  def contact_params
    params.require(:contact).permit(:name, :phone, :gender, :dob, :age, :house_name, :alternate_contact, :ward, :landmark, :panchayat_id, :phc, :health_worker, :number_health_worker, :user_id, :old_case_id, :description)
  end

  def consultation_params
    params.require(:contact).permit(:consultation_type).merge(status: 'pending', action: action, creator_id: current_user.id, source: current_user.source)
  end
end
