class WorkoutsController < ApplicationController
  before_action :set_workout, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  # GET /workouts
  # GET /workouts.json
  def index
    @workouts = current_user.workouts.all
  end

  # GET /workouts/1
  # GET /workouts/1.json
  def show
	store_location
  end

  def add_exercise
  end
  # GET /workouts/new
  def new
    @workout = current_user.workouts.new
	@exercises = current_user.exercises.all
  end

  # GET /workouts/1/edit
  def edit

  end

  # POST /workouts
  # POST /workouts.json
  def create
    @workout = current_user.workouts.build(workout_params)
    respond_to do |format|
      if @workout.save
			params[:workout].each do |key,value|
				if key == 'exercise_ids'
					@exercises = Exercise.find(value.reject!{|a| a==""})
					@workout.exercises << @exercises		
				end
			end
        format.html { redirect_to @workout, notice: 'Workout was successfully created.' }
        format.json { render :show, status: :created, location: @workout }
      else
        format.html { render :new }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workouts/1
  # PATCH/PUT /workouts/1.json
  def update
	

   respond_to do |format|
	
     if @workout.update(workout_params)
			params[:workout].each do |key,value|
				if key == 'exercise_ids'
					@exercises = Exercise.find(value.reject!{|a| a==""})
					@workout.exercises << @exercises		
				end
			end
	   format.html { redirect_to @workout, notice: 'Workout was successfully updated.' }
       format.json { render :show, status: :ok, location: @workout }
     else
       format.html { render :edit }
       format.json { render json: @workout.errors, status: :unprocessable_entity }
     end
   end
  end

  # DELETE /workouts/1
  # DELETE /workouts/1.json
  def destroy
    @workout.destroy
    respond_to do |format|
      format.html { redirect_to workouts_url, notice: 'Workout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout
      @workout = current_user.workouts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workout_params
      params.require(:workout).permit(:description, :name,
						:exercise_ids => [:exercise_id])
    end
	
	def correct_user
		@workout = current_user.workouts.find_by(id: params[:id])
      redirect_to workouts_path if @workout.nil?
    end
end
