class Api::V1::ProgramsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
    user_programs = current_user.programs.order(id: :asc)
    user_programs.each_with_index do |prog, key|
      labels = prog.labels
      user_programs[key] = prog.attributes
      user_programs[key][:labels] = labels
    end
    render json: {:status => 'ok', :programs => user_programs}, status: 200
  end

  def show
    begin
      program_id = params[:id]
      raise 'Invalid program id.' unless program_id

      program = Program.where(id: program_id, user_id: current_user.id).first
      raise 'Invalid program id.' unless program

      prog = program.attributes
      prog[:labels] = program.labels

      res = {:status => 'ok', :program => prog}
    rescue Exception => e
      res = {status: 'error', error: e.message}
    end
    render json: res, status: 200
  end

  def create
    labels = params.permit(labels: [:name, :order, :labeltype_id])[:labels].values
    program = params.permit(:name, :level, :goal, :private)
    begin
      ActiveRecord::Base.transaction do
        raise 'Invalid program name.' unless program[:name]
        raise 'Invalid program level.' unless program[:level]
        raise 'Invalid program goal.' unless program[:goal]
        raise 'Invalid program private.' unless program[:private]
        new_program = current_user.programs.create!(program)
        raise 'Cannot save the program.' unless new_program

        if !labels.empty?
          raise 'Cannot add labels to program.' unless new_program.labels.create!(labels)
        end

      end
      res = {status: 'ok'}
    rescue Exception => e
      res = {status: 'error', error: e.message}
    end
    render json: res
  end

  def update
    labels_params = params.permit(labels: [:id, :name, :labeltype_id])[:labels].values if params[:labels]
    program_params = params.permit(:id, :name, :level, :goal, :private)

    begin
      raise 'Invalid program id.' unless program_params[:id]
      program = Program.find_by_id(program_params[:id])
      raise 'Program not found.' unless program
      program.update(program_params)

      if params[:labels]
        labels_ids = []
        labels_params.each do |label|
          labels_ids << label['id']
        end
        program.labels.update(labels_ids, labels_params)
      end
      res = {status: 'ok'}
    rescue Exception => e
      res = {status: 'error', error: e.message}
    end
    render json: res, status: 200
  end

  def destroy
    program_id = params[:id]
    begin
      raise 'Invalid program id.' unless program_id
      program = current_user.programs.find_by_id(program_id)
      raise 'Invalid program id.' unless program
      program.destroy
      res = {status: 'ok'}
    rescue Exception => e
      res = {status: 'error', error: e.message}
    end
    render json: res, status: 200
  end
end