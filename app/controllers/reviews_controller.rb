class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @hospital = Hospital.find(params[:hospital_id])
    @review = @hospital.reviews.build
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @hospital = Hospital.find(params[:hospital_id])
    @review = @hospital.reviews.build(review_params)
    if(params[:review][:grade] == "★")
      @review.grade = 1
      @review.save
    elsif (params[:review][:grade]=="★★")
      @review.grade = 2
      @review.save
    elsif (params[:review][:grade]=="★★★")
      @review.grade = 3
      @review.save
    elsif (params[:review][:grade]=="★★★★")
      @review.grade = 4
      @review.save
    else
      @review.grade = 5
      @review.save
    end

    @review.r_user_name = current_user.name
    respond_to do |format|
      if @review.save
        flash[:success] = "후기 작성 성공"
        format.html { redirect_to hospital_path(:id => params[:hospital_id]) }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        flash[:success] = "수정 성공"
        format.html { redirect_to @review }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @hospital = Hospital.find(params[:hospital_id])
    @review = @hospital.reviews.find(params[:id])
    @review.destroy
    respond_to do |format|
      flash[:success] = "삭제 성공"
      format.html { redirect_to @hospital }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:r_title, :r_content, :grade ,:user_id, :hospital_id)
    end
end
