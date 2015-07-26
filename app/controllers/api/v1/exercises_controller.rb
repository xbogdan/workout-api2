class Api::V1::ExercisesController < ApplicationController
  # before_action :authenticate_with_token!
  respond_to :json

  def index
    begin
      if params[:filter]
        exercises = Exercise.select(:id, :name).where("name LIKE ?", "#{params[:filter]}%")# find(:all, :conditions=>['name LIKE ?', "%#{params[:filter]}%"])
      else
        exercises = Exercise.all
      end
      render json: { exercises: exercises }, status: 200
    rescue Exception => e
      render json: { error: 'error' }, status: 500
    end
  end
end
