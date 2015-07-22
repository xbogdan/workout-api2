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
      prog[:program_days_attributes] = []
      program_days = program.program_days.order('ord ASC')
      program_days.each do |pd|
        day = pd.attributes
        day[:program_day_exercises_attributes] = []
        exercises = pd.program_day_exercises.joins('left join exercises on exercises.id = program_day_exercises.exercise_id left join muscle_groups on muscle_groups.id = exercises.muscle_group_id').select('program_day_exercises.id, exercises.name, muscle_groups.name as muscle_groups_name').order('ord ASC')
        exercises.each_with_index do |ex, i|
          exercise = ex.attributes
          exercise[:program_day_exercise_sets_attributes] = ex.program_day_exercise_sets.order('ord ASC')
          day[:program_day_exercises_attributes] << exercise
        end
        prog[:program_days_attributes] << day
      end

      res = {:status => 'ok', :program => prog}
    rescue Exception => e
      res = {status: 'error', error: e.message}
    end
    render json: res, status: 200
  end

  def create
    program = params.permit(:name, :level, :goal, :private, program_days_attributes: [:name, program_day_exercises_attributes: [:exercise_id, program_day_exercise_sets_attributes: [:reps, :program_day_exercise_id]]])
    begin
      ActiveRecord::Base.transaction do
        raise 'Invalid program name.' unless program[:name]
        raise 'Invalid program level.' unless program[:level]
        raise 'Invalid program goal.' unless program[:goal]
        raise 'Invalid program private.' unless program[:private]
        new_program = current_user.programs.create!(program)
        raise 'Cannot save the program.' unless new_program

      end
      res = {status: 'ok'}
    rescue Exception => e
      res = {status: 'error', error: e.message}
    end
    render json: res
  end

  def update
    program_params = params.require(:program).permit(:id, :name, :level, :goal, :private, program_days_attributes: [:id, :name, :ord, program_day_exercises_attributes: [:id, :exercise_id, :ord, program_day_exercise_sets_attributes: [:id, :reps, :ord, :program_day_exercise_id]]])

    begin
      raise 'Invalid program id.' unless program_params[:id]
      program = Program.find_by_id(program_params[:id])
      raise 'Program not found.' unless program
      program.update!(program_params)

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
