class ExercisesController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: :destroy
  
  # GET /exercises
  # GET /exercises.json
  def index
    @exercises = current_user.exercises.paginate(page: params[:page], :per_page => 3)
	
  end

  # GET /exercises/1
  # GET /exercises/1.json
  def show
	set_exercise
  end

  # GET /exercises/new
  def new
    @exercise = current_user.exercises.new
  end

  # GET /exercises/1/edit
  def edit
  end

  # POST /exercises
  # POST /exercises.json
  def create
    @exercise = current_user.exercises.build(exercise_params)

    respond_to do |format|
      if @exercise.save
        format.html { redirect_to exercise_weight_logs_path(@exercise)}
        format.json { render :show, status: :created, location: @exercise }
      else
        format.html { render :new }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exercises/1
  # PATCH/PUT /exercises/1.json
  def update
    respond_to do |format|
      if @exercise.update(exercise_params)
        format.html { redirect_to @exercise, notice: 'Exercise was successfully updated.' }
        format.json { render :show, status: :ok, location: @exercise }
      else
        format.html { render :edit }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercises/1
  # DELETE /exercises/1.json
  def destroy
    @exercise.destroy
    respond_to do |format|
      format.html { redirect_to exercises_url, notice: 'Exercise was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise
      @exercise = current_user.exercises.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exercise_params
      params.require(:exercise).permit(:name)
    end
	def correct_user
		@exercise = current_user.exercises.find_by(id: params[:id])
      redirect_to root_url if @exercise.nil?
    end
end
