class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_not_created_response

    def index
        campers = Camper.all
        render json: campers, status: :ok
    end
    
    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperActivitiesSerializer
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end
    

    private

    def camper_params
        params.permit(:id, :name, :age)
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end

    def render_not_created_response
        render json: { errors: ["validation errors"] }, status: :unprocessable_entity
    end


end
