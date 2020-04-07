class MedicalReqsController < ApplicationController
def create
    @contact = Contact.find(params[:contact_id])
    @medical_req = @contact.medical_reqs.create(medical_req_params)
   # @medical_req.user_id = current_user.id

    if @medical_req.save
      respond_to do |format|
        format.html { redirect_to @contact, notice: 'Request was Added Successfully' }
      end
    else
      flash.now[:danger] = 'There was an error saving the Non Medical Requirement, Contact Your Admin'
    end
  end

  def fullfill
    @medical_req = MedicalReq.find(params[:id])
    @contact = Contact.find(params[:contact_id])
    @medical_req.fullfilled = true

    if @medical_req.save
      respond_to do |format|
        format.html { redirect_to @contact, notice: 'Request was marked as Complete' }
      end
    else
      flash.now[:danger] = 'There was an error saving the Non Medical Requirement, Contact Your Admin'
    end
  end

  def not_able
    @medical_req = MedicalReq.find(params[:id])
    @contact = Contact.find(params[:contact_id])
    @medical_req.not_able_type = params[:not_able_type]

    if @medical_req.save
      respond_to do |format|
        format.html { redirect_to @contact, notice: 'Request was marked as Not Able to Complete' }
      end
    else
      flash.now[:danger] = 'There was an error saving the Non Medical Requirement, Contact Your Admin'
    end
  end

  def destroy
    @medical_req = MedicalReq.find(params[:id])
    @contact = Contact.find(params[:contact_id])

    @medical_req.destroy
    respond_to do |format|
      format.html { redirect_to @contact, alert: 'Request was cancelled' }
      format.json { head :no_content }
    end
  end

  private

  def medical_req_params
    params[:medical_req].permit(:need_medicines, :fullfilled, :requirement_type, :other_needs)
  end
end
