class WorkoutsController < ApplicationController
  before_action :set_workout, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @workouts = Workout.authenticated_users_workouts(current_user.id).ordered
  end

  def show; end

  def new
    @workout = Workout.new
  end

  def create
    @workout = Workout.new(workout_params)
    @workout.user = current_user

    if @workout.save
      redirect_to workouts_path, notice: 'Workout was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @workout.update(workout_params)
      redirect_to workouts_path, notice: 'Workout was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @workout.destroy

    respond_to do |format|
      format.html { redirect_to workouts_path, notice: 'Workout was successfully destroyed.' }
      format.turbo_stream
    end
  end

  private

  def set_workout
    @workout = Workout.find(params[:id])
  end

  def workout_params
    params.require(:workout).permit(:name)
  end
end
