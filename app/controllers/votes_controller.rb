class VotesController < ApplicationController


  respond_to :js

  def upvote
    @user = current_user
    @comment = Comment.find(params[:comment_id])
    @user.upvote!(@comment)
  end

  def downvote
    @user = current_user
    @comment = Comment.find(params[:comment_id])
    @upvote = @comment.votes.find_by_comment_id(params[:comment_id])
    @upvote.destroy!
  end 
  
end
