class SubmissionsController < ApplicationController
  before_action :find_submission, only: [:show, :edit, :update, :destroy]
  before_action :ensure_current_user_is_superadmin!, only: [:index, :destroy]

  def index
    @submissions = Submission.all
  end


  def new
    @submission = Submission.new
  end

  def show
  end

  def create
    @submission = Submission.new(submission_params)
    if @submission.save
      flash[:notice] = "Successfully created submission."
      redirect_to @submission
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @submission.update_attributes(submission_params)
      flash[:notice] = "Successfully updated submission."
      redirect_to @submission
    else
      render :action => 'edit'
    end
  end

  def destroy
    @submission.destroy
    flash[:notice] = "Successfully destroyed submission."
    redirect_to submissions_url
  end

  private

    def find_submission
      @submission = Submission.find_by_uniq_id(params[:id])
    end

    def submission_params
      params.require(:submission).permit(:name, :email, :phone_number, :bio, :sample_program)
    end
end

