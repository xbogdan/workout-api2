class Api::V1::TrackDayExercisesController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def create
    begin
      raise 'Invalid id.' unless params[:day_id]
      raise 'Invalid exercise id.' unless params[:exercise_id]

      exercise = Exercise.find_by_id(params[:exercise_id])
      raise 'Invalid exercise id.' unless exercise

      day = TrackDay.find_by_id(params[:day_id])
      raise 'Invalid id.' unless day

      track = current_user.tracks.find_by_id(day.track_id)
      raise 'Invalid id.' unless track

      track_day_exercise = TrackDayExercise.create!(track_day_id: day.id, exercise_id: exercise.id)

      res = {status: 'ok', track_day_exercise_id: track_day_exercise.id }
      status = 201
    rescue Exception => e
      res = {status: 'error', error: e.message}
      status = 400
    end

    render json: res, status: status
  end

  def update
    begin
      raise 'Invalid id.' unless params[:id]
      raise 'Invalid exercise id.' unless params[:exercise_id]

      track_day_exercise = TrackDayExercise.find_by_id params[:id]
      raise 'Invalid id.' unless track_day_exercise

      exercise = Exercise.find_by_id(params[:exercise_id])
      raise 'Invalid exercise id.' unless exercise

      day = TrackDay.find_by_id(track_day_exercise.track_day_id)
      raise 'Invalid id.' unless day

      track = current_user.tracks.find_by_id(day.track_id)
      raise 'Invalid id.' unless track

      track_day_exercise.update! exercise_id: params[:exercise_id]

      res = {status: 'ok'}
      status = 200
    rescue Exception => e
      print e.message
      res = {status: 'error', error: e.message}
      status = 400
    end

    render json: res, status: status
  end

  def destroy
    begin
      raise 'Invalid id.' unless params[:id]

      exercise = TrackDayExercise.find_by_id(params[:id])
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
