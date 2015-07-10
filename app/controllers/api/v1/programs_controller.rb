class Api::V1::ProgramsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
    user_programs = current_user.programs.order(id: :asc)
    user_programs.each_with_index do |prog, key|
      days = prog.program_days
      user_programs[key] = prog.attributes
      user_programs[key][:days] = days
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
      prog[:days] = []
      program_days = program.program_days
      program_days.each do |pd|
        day = pd.attributes
        day[:exercises] = []
        exercises = pd.program_day_exercises.joins('left join exercises on exercises.id = program_day_exercises.exercise_id left join muscle_groups on muscle_groups.id = exercises.muscle_group_id').select('program_day_exercises.id, exercises.name, muscle_groups.name as muscle_groups_name')
        exercises.each_with_index do |ex, i|
          exercise = ex.attributes
          exercise[:sets] = ex.program_day_exercise_sets
          day[:exercises] << exercise
        end
        prog[:days] << day
      end
      # Program.joins('LEFT JOIN program_days on programs.id = program_days.program_id LEFT JOIN program_day_exercises ON program_days.id = program_day_exercises.program_day_id').order('program_days.id')

      res = {:status => 'ok', :program => prog}
    rescue Exception => e
      res = {status: 'error', error: e.message}
    end
    render json: res, status: 200
  end

  def create
    days = params.permit(days: [:name])[:days].values
    program = params.permit(:name, :level, :goal, :private)
    begin
      ActiveRecord::Base.transaction do
        raise 'Invalid program name.' unless program[:name]
        raise 'Invalid program level.' unless program[:level]
        raise 'Invalid program goal.' unless program[:goal]
        raise 'Invalid program private.' unless program[:private]
        new_program = current_user.programs.create!(program)
        raise 'Cannot save the program.' unless new_program

        if !days.empty?
          raise 'Cannot add days to program.' unless new_program.program_days.create!(days)
        end

      end
      res = {status: 'ok'}
    rescue Exception => e
      res = {status: 'error', error: e.message}
    end
    render json: res
  end

  def update
    days_params = params.permit(days: [:id, :name])[:days].values if params[:days]
    program_params = params.permit(:id, :name, :level, :goal, :private)

    begin
      raise 'Invalid program id.' unless program_params[:id]
      program = Program.find_by_id(program_params[:id])
      raise 'Program not found.' unless program
      program.update(program_params)

      if params[:days]
        days_ids = []
        days_params.each do |label|
          days_ids << label['id']
        end
        program.program_days.update(days_ids, days_params)
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
