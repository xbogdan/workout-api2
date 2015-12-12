class Api::V1::TrackDaysController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def create
    track_params = params.permit(:track_id, :date)
    begin
      track_id = params[:track_id]
      raise 'Invalid track id.' unless track_id

      track = Track.where(id: track_id, user_id: current_user.id).first
      raise 'Invalid track id.' unless track

      new_track_day = nil
      ActiveRecord::Base.transaction do
        new_track_day = track.track_days.create!(date: track_params[:date])
        raise 'Cannot save the track day.' unless new_track_day
      end

      res = { status: 'ok', day_id: new_track_day.id }
      status = 201
    rescue Exception => e
      res = {status: 'error', error: e.message}
      status = 400
    end

    render json: res, status: status
  end

  def update
    params = params.permit(:id, :date)
    begin
      raise 'Invalid day id.' unless params[:id]

      day = TrackDay.find_by_id(id)
      raise 'Invalid day id.' unless day

      track = current_user.tracks.find_by_id(day.track_id)
      raise 'Invalid day id.' unless track

      day.date = params[:date]
      # day.update()

      res = {status: 'ok'}
      status = 200
    rescue Exception => e
      res = {status: 'error', error: e.message}
      status = 400
    end

    render json: res, status: status
  end

  def destroy
    id = params[:id]
    begin
      raise 'Invalid day id.' unless id

      day = TrackDay.find_by_id(id)
      raise 'Invalid day id.' unless day

      track = current_user.tracks.find_by_id(day.track_id)
      raise 'Invalid day id.' unless track

      day.destroy
      res = {status: 'ok'}
      status = 200
    rescue Exception => e
      res = {status: 'error', error: e.message}
      status = 400
    end

    render json: res, status: status
  end
end
