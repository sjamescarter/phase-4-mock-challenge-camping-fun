class SignupsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response
# POST /signups
  def create
    camper = Camper.find(params[:camper_id])
    activity = Activity.find(params[:activity_id])
    signup = Signup.new(params.permit(:time))
    camper.signups << signup
    activity.signups << signup
    signup.save!
    render json: activity, status: :created
  end

  private

  def invalid_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
