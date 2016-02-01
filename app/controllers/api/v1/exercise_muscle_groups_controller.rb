class Api::V1::ExerciseMuscleGroupsController < ApplicationController
	before_action :authenticate_with_token!
	respond_to :json

	def index
		render json: { exercise_muscle_groups: ExerciseMuscleGroup.all }, status: 200
	end

	def create
		begin
			render json: {}, status: 201
		rescue Exception => e
			render json: { status: 'error', error: e.message }, status: 400
		end
	end
end
