class CommentsController < ApplicationController
  respond_to :js, :html
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_bug
  before_action :find_comment , only: [:destroy, :edit, :update, :comment_owner]
  before_action :comment_owner, only: [:destroy, :edit, :update]
  
  def index
    # created in order to handle renders from this controller, which produce URL 'root/posts/:id/comments'
    bug = Bug.find(params[:bug_id])
    redirect_to bug
  end  
  def show

  end
    
  def create
    @bug = Bug.find(params[:bug_id])
    @comment = @bug.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      @new_comment = @bug.comments.new
      respond_to do |format|
        format.html do
          flash[:success] = 'Your comment has been posted.'
          redirect_to @bug
        end
        format.js
      end
    else
      @new_comment = @comment
      respond_to do |format|
        format.html { render @bug }
        format.js { render action: 'failed_save' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @bug = @comment.bug
    @comment.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Comment deleted.'
        redirect_to @bug
      end
      format.js
    end
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
      params.require(:comment).permit(:description)
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
