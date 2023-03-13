class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  private

  def invalid_record(redirect_path:, resource:)
    respond_to do |format|
      format.html { redirect_to redirect_path, alert: resource.errors.full_messages }
      format.json { render json: { errors: resource.errors }, status: :unprocessable_entity }
    end
  end

  def not_found
    render json: { errors: ['Record not found'] }, status: :not_found
  end
end
