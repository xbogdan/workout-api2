  class Api::V1::TracksController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
    user_tracks = current_user.tracks.order(id: :asc)
    user_tracks.each_with_index do |track, key|
      # days = track.track_days
      # user_tracks[key] = track.attributes


      prog = track.attributes
      prog[:track_days_attributes] = []
      track_days = track.track_days.order(date: :desc)
      track_days.each do |pd|
        day = pd.attributes
        day[:track_day_exercises_attributes] = []
        exercises = pd.track_day_exercises.joins('left join exercises on exercises.id = track_day_exercises.exercise_id left join muscle_groups on muscle_groups.id = exercises.muscle_group_id').select('track_day_exercises.id, track_day_exercises.ord, track_day_exercises.exercise_id, exercises.name, muscle_groups.name as muscle_groups_name').order('track_day_exercises.ord ASC')
        exercises.each_with_index do |ex, i|
          exercise = ex.attributes
          exercise[:track_day_exercise_sets_attributes] = ex.track_day_exercise_sets.order('ord ASC')
          day[:track_day_exercises_attributes] << exercise
        end
        prog[:track_days_attributes] << day
        user_tracks[key] = prog
      end
    end
    p user_tracks[0][:track_days_attributes]
    render json: {:status => 'ok', :tracks => user_tracks}, status: 200
  end

  def show
    begin
      track_id = params[:id]
      raise 'Invalid track id.' unless track_id

      track = Track.where(id: track_id, user_id: current_user.id).first
      raise 'Invalid track id.' unless track

      prog = track.attributes
      prog[:track_days_attributes] = []
      track_days = track.track_days.order(date: :desc)
      track_days.each do |pd|
        day = pd.attributes
        day[:track_day_exercises_attributes] = []
        exercises = pd.track_day_exercises.joins('left join exercises on exercises.id = track_day_exercises.exercise_id left join muscle_groups on muscle_groups.id = exercises.muscle_group_id').select('track_day_exercises.id, track_day_exercises.ord, track_day_exercises.exercise_id, exercises.name, muscle_groups.name as muscle_groups_name').order('track_day_exercises.ord ASC')
        exercises.each_with_index do |ex, i|
          exercise = ex.attributes
          exercise[:track_day_exercise_sets_attributes] = ex.track_day_exercise_sets.order('ord ASC')
          day[:track_day_exercises_attributes] << exercise
        end
        prog[:track_days_attributes] << day
      end

      res = {:status => 'ok', :track => prog}
      status = 200
    rescue Exception => e
      res = {status: 'error', error: e.message}
      status = 400
    end
    render json: res, status: status
  end

  def create
    track = params.require(:track).permit(:name, :program_id,
                                              track_days_attributes: [:name, :date,
                                                track_day_exercises_attributes: [:exercise_id, :ord,
                                                  track_day_exercise_sets_attributes: [:reps, :weight, :ord, :track_day_exercise_id]]])
    begin
      new_track = nil
      ActiveRecord::Base.transaction do
        raise 'Invalid track name.' if track[:name].blank?
        new_track = current_user.tracks.create!(track)
        raise 'Cannot save the track.' unless new_track
      end
      res = { status: 'ok', track_id: new_track.id }
      status = 201
    rescue Exception => e
      res = { status: 'error', error: e.message }
      status = 400
    end
    render json: res, status: status
  end

  def update
    track_params = params.require(:track).permit(:id, :name, :_destroy,
                                                    track_days_attributes: [:id, :name, :date, :_destroy,
                                                      track_day_exercises_attributes: [:id, :exercise_id, :ord, :_destroy,
                                                        track_day_exercise_sets_attributes: [:id, :reps, :weight, :ord, :_destroy, :track_day_exercise_id]]])

    begin
      raise 'Invalid track id.' unless track_params[:id]
      track = Track.find_by_id(track_params[:id])
      raise 'Track not found.' unless track
      track.update!(track_params)

      res = {status: 'ok'}
      status = 200
    rescue Exception => e
      res = {status: 'error', error: e.message}
      status = 400
    end

    render json: res, status: status
  end

  def destroy
    track_id = params[:id]
    begin
      raise 'Invalid track id.' unless track_id

      track = current_user.tracks.find_by_id(track_id)
      raise 'Invalid track id.' unless track

      track.destroy
      res = {status: 'ok'}
      status = 200
    rescue Exception => e
      res = {status: 'error', error: e.message}
      status = 400
    end

    render json: res, status: status
  end
end
