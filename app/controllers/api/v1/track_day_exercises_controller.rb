class Api::V1::TrackDayExercisesController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def create
    
  end

  def destroy
    id = params[:id]
    begin
      raise 'Invalid id.' unless id

      exercise = TrackDayExercise.find_by_id(id)
      raise 'Invalid id.' unless exercise

      day = TrackDay.find_by_id(exercise.track_day_id)
      raise 'Invalid id.' unless day

      track = current_user.tracks.find_by_id(day.track_id)
      raise 'Invalid id.' unless track

      exercise.destroy
      res = {status: 'ok'}
      status = 200
    rescue Exception => e
      res = {status: 'error', error: e.message}
      status = 400
    end

    render json: res, status: status
  end
end
