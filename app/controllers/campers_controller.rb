class CampersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

# GET /campers 
  def index
    render json: Camper.all
  end

# GET /campers/:id
  def show
    camper = Camper.find(params[:id])
    render json: camper, serializer: CamperActivitySerializer, status: :ok
  end
  
# POST /campers
  def create
    camper = Camper.create!(params.permit(:name, :age))
    render json: camper, status: :created
  end

  private

  def not_found_response
    render json: { error: "Camper not found" }, status: :not_found
  end

  def invalid_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
