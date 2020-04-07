class NonMedicalReqsController < ApplicationController
  def create
    @contact = Contact.find(params[:contact_id])
    @non_medical_req = @contact.non_medical_reqs.create(non_medical_req_params)
   # @non_medical_req.user_id = current_user.id

    if @non_medical_req.save
      respond_to do |format|
        format.html { redirect_to @contact, notice: 'Request was Added Successfully' }
      end
    else
      flash.now[:danger] = 'There was an error saving the Non Medical Requirement, Contact Your Admin'
    end
  end

  def fullfill
    @non_medical_req = NonMedicalReq.find(params[:id])
    @contact = Contact.find(params[:contact_id])
    @non_medical_req.fullfilled = true

    if @non_medical_req.save
      respond_to do |format|
        format.html { redirect_to @contact, notice: 'Request was marked as Complete' }
      end
    else
      flash.now[:danger] = 'There was an error saving the Non Medical Requirement, Contact Your Admin'
    end
  end

  def not_able
    @non_medical_req = NonMedicalReq.find(params[:id])
    @contact = Contact.find(params[:contact_id])
    @non_medical_req.not_able_type = params[:not_able_type]

    if @non_medical_req.save
      respond_to do |format|
        format.html { redirect_to @contact, notice: 'Request was marked as Complete' }
      end
    else
      flash.now[:danger] = 'There was an error saving the Non Medical Requirement, Contact Your Admin'
    end
  end

  def destroy
    @non_medical_req = NonMedicalReq.find(params[:id])
    @contact = Contact.find(params[:contact_id])

    @non_medical_req.destroy
    respond_to do |format|
      format.html { redirect_to @contact, alert: 'Request was cancelled' }
      format.json { head :no_content }
    end
  end

  private

  def non_medical_req_params
    params[:non_medical_req].permit(:need_food, :fullfilled, :requirement_type, :other_needs)
  end
end
