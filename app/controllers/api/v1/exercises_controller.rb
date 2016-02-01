class Api::V1::ExercisesController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
    begin
      exercises = Exercise.all
      render json: { exercises: exercises }, status: 200
    rescue Exception => e
      render json: { status: 'error', error: e.message }, status: 500
    end
  end

  # def index
  #   begin
  #     if !params[:filter].blank?
  #       exercises = Exercise
  #                     .joins("LEFT JOIN muscle_groups ON exercises.muscle_group_id = muscle_groups.id")
  #                     .select('exercises.*, muscle_groups.name as muscle_group_name')
  #                     .where("exercises.name LIKE ?", "#{params[:filter]}%")
  #                     .order(muscle_group_id: :asc)
  #     else
  #       exercises = Exercise
  #                     .joins("LEFT JOIN muscle_groups ON exercises.muscle_group_id = muscle_groups.id")
  #                     .select('exercises.*, muscle_groups.name as muscle_group_name')
  #                     .order(muscle_group_id: :asc)
  #     end
  #
  #     if !params[:grouped].blank? && params[:grouped] == '1'
  #       current_group = -1
  #       exercises_grouped = []
  #       empty = true
  #       exercises.each_with_index do |ex, index|
  #         if empty || ex.muscle_group_id != exercises_grouped[current_group][:muscle_group_id]
  #           empty = false
  #           current_group += 1
  #           exercises_grouped << { exercises: [ex], muscle_group_name: ex.muscle_group_name, muscle_group_id: ex.muscle_group_id }
  #         else
  #           exercises_grouped[current_group][:exercises] << ex
  #         end
  #       end
  #
  #       response = exercises_grouped
  #     else
  #       response = exercises
  #     end
  #
  #     render json: { exercises: response }, status: 200
  #   rescue Exception => e
  #     render json: { status: 'error', error: e.message }, status: 500
  #   end
  # end

  def create
    begin
      raise 'Invalid exercise name' if params[:name].blank?
      raise 'Invalid muscle group id' if params[:muscle_group_id].blank?

      name = params[:name].downcase.strip.capitalize
      exercise = Exercise.where("name = ?", "#{name}").first
      raise 'Exercise already exists' if exercise

      muscle_group = MuscleGroup.find_by_id params[:muscle_group_id]
      raise 'Invalid muscle group id' unless muscle_group

      Exercise.create!(name: name, muscle_group_id: params[:muscle_group_id], user_id: current_user.id)

      render json: {}, status: 201
    rescue Exception => e
      render json: { status: 'error', error: e.message }, status: 400
    end
  end

  def destroy
    begin
      raise 'Invalid exercise id' if params[:id].blank?
      exercise = Exercise.where(id: params[:id], user_id: current_user.id).first
      raise 'Invalid exercise id' if !exercise

      exercise.destroy
      render json: {}, status: 200
    rescue Exception => e
      render json: { status: 'error', error: e.message }, status: 400
    end
  end
end
