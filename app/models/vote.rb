class Vote < ApplicationRecord
  belongs_to :comment
  belongs_to :user

  def self.thumbs_up_total(comment)
    comment.votes.where(vote_status: true).size
  end

  def self.thumbs_down_total(comment)
    comment.votes.where(vote_status: false).size
  end

  def self.vote_up_down_total(comment)
    Vote.thumbs_up_total(comment) - Vote.thumbs_down_total(comment)
  end

end
