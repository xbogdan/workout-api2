class Api::V1::MuscleGroupsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
    render json: { muscle_groups: MuscleGroup.all }, status: 200
  end

  def create
    begin
      raise 'Invalid muscle group name' if params[:name].blank?

      name = params[:name].downcase.strip.capitalize
      muscle_group = MuscleGroup.where("name = ?", "#{name}").first
      raise 'Muscle group already exists' if muscle_group

      MuscleGroup.create!(name: params[:name])

      render json: {}, status: 201
    rescue Exception => e
      render json: { status: 'error', error: e.message }, status: 400
    end
  end
end
