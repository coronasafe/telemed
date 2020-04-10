class ConsultationsController < ApplicationController
  before_action :set_consultation, only: [:show, :edit, :update, :destroy]
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def create
    @contact = Contact.find(params[:contact_id])
    consultation = @contact.consultations.new(consultation_create_params)

    if consultation.save!
      respond_to do |format|
        format.html { redirect_to @contact, notice: 'Request was Added Successfully' }
      end
    else
      flash.now[:danger] = 'There was an error saving the Non Medical Requirement, Contact Your Admin'
    end
  end

  def update
    @consultation.update_attributes(consultation_update_params)

    if @consultation.save!
      @consultation.consultation_symptoms.destroy_all

      Symptom.where(id: params['consultation']['symptom_ids']).each do |s|
        ConsultationSymptom.create!(consultation: @consultation, symptom: s)
      end
      respond_to do |format|
        format.html { redirect_to @consultation, notice: 'Request was Added Successfully' }
      end
    else
      flash.now[:danger] = 'There was an error saving the Non Medical Requirement, Contact Your Admin'
    end
  end

  def show
  end

  private

  def set_contact
    @contact = @consultation.contact
  end

  def set_consultation
    @consultation = Consultation.find(params[:id])
  end

  def consultation_create_params
    params.require(:consultation).permit(:consultation_type, :source).merge(status: 'pending', creator_id: current_user.id)
  end

  def consultation_update_params
    params.require(:consultation).permit(:consultation_type, :source, :reason_for_calling, :other_details,
      :current_status, :category, :antenatal, :quarantined, :quarantined_on, :endemic,
      :family_members_count, :elderly, :comorbidities, :prescription_given, :notes, :test_status, :sample_taken_on,
      :action_id, :shift_from, :shift_to, :reason, :status, :surveillance, :contact_id, :doctor_id, :symptom_ids, :action_id
    )
  end
end
