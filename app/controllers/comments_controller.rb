class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_bug
  before_action :find_comment , only: [:destroy, :edit, :update, :comment_owner]
  before_action :comment_owner, only: [:destroy, :edit, :update]
  
  def show

  end
    
  def create
    @comment = @bug.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    respond_to do |format|
      if @comment.save
          format.html { redirect_to @bug }
          format.js  
      else
         render 'new'
         
      end
    end  
  end

  def destroy
    @comment.destroy
    redirect_to bug_path(@bug)
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
        redirect_to bug_path(@bug)
    else
        render 'edit'
    end
  end  

  
  private
    def find_bug
      @bug = Bug.find(params[:bug_id])
    end
    
    def comment_params
      params.require(:comment).permit(:title, :description)
    end
    def find_comment
      @comment = @bug.comments.find(params[:id])
    end
    def comment_owner
      unless current_user.id == @comment.user_id
          flash[:notice] = "You Shall Not Pass"
          redirect_to @bug
      end
    end  
end
