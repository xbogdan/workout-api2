class Api::V1::TrackDaysController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def create
    begin
      raise 'Invalid track id.' unless params[:track_id]

      track = Track.find_by_id(params[:track_id])
      raise 'Invalid track id.' unless track

      raise 'Invalid track id.' unless track.user_id = current_user.id

      new_track_day = nil
      ActiveRecord::Base.transaction do
        new_track_day = track.track_days.create!(date: params[:date])
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
    begin
      raise 'Invalid id.' unless params[:id]

      track_day = TrackDay.find_by_id(id)
      raise 'Invalid id.' unless track_day

      track = current_user.tracks.find_by_id(track_day.track_id)
      raise 'Invalid id.' unless track

      track_day.update! date: params[:date]

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
      raise 'Invalid day id.' unless params[:id]

      day = TrackDay.find_by_id(params[:id])
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
