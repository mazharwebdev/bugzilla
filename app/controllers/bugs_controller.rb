class BugsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_bug, only: [:show, :edit, :update, :destroy]
   
  def index
    @bugs = Bug.all.order("deadline DESC")
  end

  def show
    @comments = Comment.where(bug_id: @bug).order("created_at ASC")
  end

  def new
    @bug = Bug.new
    @project =  Project.find(params[:project]) 
    # get Project ID from New Link of Bug
    @project_idx = session[:projectid] = params[:project]
  end

  def edit
  end

  def create
    @bug = Bug.new(bug_params)
    @pid = Project.find(session[:projectid])
    @bug.project_id = @pid.id
    @bug.created_id = current_user.id
    if current_user.role == "manager" || current_user.role == "tester" 
      respond_to do |format|
        if @bug.save
          format.html { redirect_to @bug, notice: 'Bug was successfully created.' }
          format.json { render :show, status: :created, location: @bug }
        else
          format.html { render :new }
          format.json { render json: @bug.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_bug_path , :flash => { :error => "Insufficient rights!" }  
    end   
  end

  def update
    respond_to do |format|
      if @bug.update(bug_params)
          format.html { redirect_to @bug, notice: 'Bug was successfully updated.' }
          format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private
    def set_bug
      @bug = Bug.find(params[:id])
    end
    def bug_params
      params.require(:bug).permit(:title, :description, :deadline, :bug_type ,:status, :project_id, :created_id, :developed_id, :screenshot )
    end
end
