class Api::V1::TrackDayExerciseSetsController < ApplicationController
  def create
    begin
      raise 'Invalid track day exercise id.' unless params[:track_day_exercise_id]

      raise 'Invalid reps.' unless params[:reps]
      raise 'Invalid weight.' unless params[:weight]
      # raise 'Invalid ord.' unless params[:ord]  # TODO add

      track_day_exercise = TrackDayExercise.find_by_id params[:track_day_exercise_id]
      raise 'Invalid track day exercise id.' unless track_day_exercise

      raise 'Invalid id.' unless track_day_exercise.user.id == current_user.id

      track_day_exercise.track_day_exercise_sets.create! reps: params[:reps], weight: params[:weight]

      res = {status: 'ok'}
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

      new_params = {}
      if params.has_key :reps
        new_params[:reps] = params[:reps]
      end

      if params.has_key :weight
        new_params[:weight] = params[:weight]
      end

      if params.has_key :ord
        new_params[:ord] = params[:ord]
      end

      track_day_exercise_set = TrackDayExerciseSet.find_by_id params[:id]
      raise 'Invalid track day exercise id.' unless track_day_exercise_set

      raise 'Invalid id.' unless track_day_exercise_set.user.id == current_user.id

      track_day_exercise.track_day_exercise_sets.update! new_params

      res = {status: 'ok'}
      status = 200
    rescue Exception => e
      res = {status: 'error', error: e.message}
      status = 400
    end

    render json: res, status: status
  end

  def destroy
    begin
      raise 'Invalid id.' unless params[:id]

      track_day_exercise_set = TrackDayExerciseSet.find_by_id params[:id]
      raise 'Invalid id.' unless track_day_exercise_set

      raise 'Invalid id.' unless track_day_exercise_set.user.id == current_user.id

      track_day_exercise_set.destroy

      res = {status: 'ok'}
      status = 200
    rescue Exception => e
      res = {status: 'error', error: e.message}
      status = 400
    end

    render json: res, status: status
  end
end
