class FollowupsController < ApplicationController
  def create
    @consultation = Consultation.find(params[:consultation_id])
    followup = @consultation.followups.new(consultation_create_params)

    if followup.save!
      respond_to do |format|
        format.html { redirect_to @consultation, notice: 'Request was Added Successfully' }
      end
    else
      flash.now[:danger] = 'There was an error saving followup, Contact Your Admin'
    end
  end

  def complete
    @consultation = Consultation.find(params[:consultation_id])
    f = @consultation.followups.find(params[:id])
    if f.update!(completed_by: current_user, completed_at: Time.zone.now)
      respond_to do |format|
        format.html { redirect_to @consultation, notice: 'Request was Completed Successfully' }
      end
    else
      flash.now[:danger] = 'There was an error saving followup, Contact Your Admin'
    end
  end

  def consultation_create_params
    params.require(:followup).permit(:action_id).merge(user_id: current_user.id)
  end
end
