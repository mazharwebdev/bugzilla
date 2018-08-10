class VotesController < ApplicationController


  respond_to :js

  def upvote
    @user = current_user
    @comment = Comment.find(params[:comment_id])
    existing_record_true = @comment.votes.find_by(vote_status: true, user_id: @user.id ,comment_id: params[:comment_id])
    existing_record_false = @comment.votes.find_by(vote_status: false, user_id: @user.id ,comment_id: params[:comment_id])

    if !existing_record_true
        if !existing_record_false
            # Code For Save True Value
            @vote = Vote.create(vote_status: params[:vote_status], user_id: current_user.id, comment_id: params[:comment_id])
            if @vote.save
               respond_to do|format|
                format.js
               end
            else
              respond_to do|format|
               format.js {render status: 403, js: "alert('Something Wrong with Data')"}
              end
            end
        else
             @vote =Vote.find_by(vote_status: false, user_id: current_user.id, comment_id: params[:comment_id])
             @vote.vote_status = "true"
             @vote.user_id = current_user.id
             @vote.comment_id = params[:comment_id]
             if @vote.save!
                respond_to do|format|
                format.js
             end
          else
            respond_to do|format|
             format.js {render status: 403, js: "alert('Something Wrong with Data')"}
            end
          end
        end  
        
          #update      
    else
      respond_to do|format|
        format.js {render status: 403, js: "alert('You can only vote a Comment once')"}
      end
    end  

  end

  def downvote
    @user = current_user
    @comment = Comment.find(params[:comment_id])
    existing_record_false = @comment.votes.find_by(vote_status: false, user_id: @user.id ,comment_id: params[:comment_id])
    existing_record_true = @comment.votes.find_by(vote_status: true, user_id: @user.id ,comment_id: params[:comment_id])

    if !existing_record_false
        if !existing_record_true
          # Code For Save True Value
            @vote = Vote.create(vote_status: params[:vote_status], user_id: current_user.id, comment_id: params[:comment_id])
            if @vote.save
               respond_to do|format|
               format.js
               end
            else
               respond_to do|format|
               format.js {render status: 403, js: "alert('Something Wrong with Data111')"}
              end
            end
        else
             @vote =Vote.find_by(vote_status: true, user_id: current_user.id, comment_id: params[:comment_id])
             @vote.vote_status = "false"
             @vote.user_id = current_user.id
             @vote.comment_id = params[:comment_id]
             puts "2===================================================" 
             puts @vote.inspect
             puts "2===================================================" 
             if @vote.save!
                respond_to do|format|
                format.js
             end
          else
            respond_to do|format|
             format.js {render status: 403, js: "alert('Something Wrong with Data222')"}
            end
          end
        end  
    else
      respond_to do|format|
        format.js {render status: 403, js: "alert('You can only vote a Comment once')"}
      end
    end  
  end 
  
end
