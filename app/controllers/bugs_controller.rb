class BugsController < ApplicationController
  before_action :set_bug, only: [:show, :edit, :update, :destroy]
   
  def index
  end

  def show
  end

  def new
    @bug = Bug.new
  end

  def edit
  end

  def create
    return render json: bug_params
    
  end

  def update
  end

  def destroy
  end

  private
    def set_bug
      @bug = Bug.find(params[:id])
    end
    def bug_params
      params.require(:bug).permit(:title, :description, :deadline,:screenshot,:bug_type ,:status, :project_id, :created_id, :developed_id )
    end
end
