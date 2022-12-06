class EnrollementsController < ApplicationController
  before_action :set_enrollement, only: %i[ show edit update destroy ]
  before_action :set_course, only: [:new, :create]

  # GET /enrollements or /enrollements.json
  def index
    @enrollements = Enrollement.all
    authorize @enrollements
  end

  # GET /enrollements/1 or /enrollements/1.json
  def show
  end

  # GET /enrollements/new
  def new
    @enrollement = Enrollement.new
  end

  # GET /enrollements/1/edit
  def edit
    authorize @enrollement
  end

  # POST /enrollements or /enrollements.json
  def create
    # authorize @enrollements
    if @course.price > 0
      flash[:alert] = "You can not access paid courses yet."
      redirect_to new_course_enrollement_path(@course)
    else
      @enrollment = current_user.buy_course(@course)
      redirect_to course_path(@course), notice: "You are enrolled!"
    end
  end

  # PATCH/PUT /enrollements/1 or /enrollements/1.json
  def update
    authorize @enrollement
    respond_to do |format|
      if @enrollement.update(enrollement_params)
        format.html { redirect_to enrollement_url(@enrollement), notice: "Enrollement was successfully updated." }
        format.json { render :show, status: :ok, location: @enrollement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enrollement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollements/1 or /enrollements/1.json
  def destroy
    @enrollement.destroy
    authorize @enrollement
    respond_to do |format|
      format.html { redirect_to enrollements_url, notice: "Enrollement was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.friendly.find(params[:course_id])
    end

    def set_enrollement
      @enrollement = Enrollement.find(params[:id])
    end


    # Only allow a list of trusted parameters through.
    def enrollement_params
      params.require(:enrollement).permit(:user_id, :course_id, :rating, :review)
    end
end
