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
        exercises = pd.program_day_exercises.joins('left join exercises on exercises.id = program_day_exercises.exercise_id left join muscle_groups on muscle_groups.id = exercises.muscle_group_id').select('program_day_exercises.id, program_day_exercises.exercise_id, exercises.name, muscle_groups.name as muscle_groups_name').order('program_day_exercises.ord ASC')
        exercises.each_with_index do |ex, i|
          exercise = ex.attributes
          exercise[:program_day_exercise_sets_attributes] = ex.program_day_exercise_sets.order('ord ASC')
          day[:program_day_exercises_attributes] << exercise
        end
        prog[:program_days_attributes] << day
      end

      res = {:status => 'ok', :program => prog}
      status = 200
    rescue Exception => e
      res = {status: 'error', error: e.message}
      status = 400
    end
    render json: res, status: status
  end

  def create
    program = params.require(:program).permit(:name, :level, :goal, :private,
                                              program_days_attributes: [:name, :rest_day, :ord
                                                program_day_exercises_attributes: [:exercise_id, :ord,
                                                  program_day_exercise_sets_attributes: [:reps, :ord, :program_day_exercise_id]]])
    begin
      ActiveRecord::Base.transaction do
        raise 'Invalid program name.' if program[:name].blank?
        raise 'Invalid program level.' if program[:level].blank?
        raise 'Invalid program goal.' if program[:goal].blank?
        raise 'Invalid program private.' if program[:private].nil?
        new_program = current_user.programs.create!(program)
        raise 'Cannot save the program.' unless new_program

      end
      res = { status: 'ok' }
      status = 201
    rescue Exception => e
      res = { status: 'error', error: e.message }
      status = 400
    end
    render json: res, status: status
  end

  def update
    program_params = params.require(:program).permit(:id, :name, :level, :goal, :private, :_destroy,
                                                    program_days_attributes: [:id, :name, :ord, :_destroy,
                                                      program_day_exercises_attributes: [:id, :exercise_id, :ord, :_destroy,
                                                        program_day_exercise_sets_attributes: [:id, :reps, :ord, :_destroy, :program_day_exercise_id]]])

    begin
      raise 'Invalid program id.' unless program_params[:id]
      program = Program.find_by_id(program_params[:id])
      raise 'Program not found.' unless program
      program.update!(program_params)

      res = {status: 'ok'}
      status = 200
    rescue Exception => e
      res = {status: 'error', error: e.message}
      status = 400
    end
    render json: res, status: status
  end

  def destroy
    program_id = params[:id]
    begin
      raise 'Invalid program id.' unless program_id
      program = current_user.programs.find_by_id(program_id)
      raise 'Invalid program id.' unless program
      program.destroy
      res = {status: 'ok'}
      status = 200
    rescue Exception => e
      res = {status: 'error', error: e.message}
      status = 400
    end
    render json: res, status: status
  end
end
