class Api::V1::ExercisesController < ApplicationController
  # before_action :authenticate_with_token!
  respond_to :json

  def index
    begin
      if params[:filter]
        exercises = Exercise.select(:id, :name).where("name LIKE ?", "#{params[:filter]}%")
      else
        exercises = Exercise.all
      end

      render json: { exercises: exercises }, status: 200
    rescue Exception => e
      render json: {}, status: 500
    end
  end

  def create
    begin
      raise 'Invalid exercise name' if params[:name].blank?
      raise 'Invalid muscle group id' if params[:muscle_group_id].blank?

      name = params[:name].downcase.strip.capitalize
      exercise = Exercise.where("name = ?", "#{name}").first
      raise 'Exercise already exists' if exercise

      muscle_group = MuscleGroup.find_by_id params[:muscle_group_id]
      raise 'Invalid muscle group id' unless muscle_group

      Exercise.create!(name: name, muscle_group_id: params[:muscle_group_id])

      render json: {}, status: 201
    rescue Exception => e
      render json: { status: 'error', error: e.message }, status: 400
    end
  end
end
