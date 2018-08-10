class Vote < ApplicationRecord
  belongs_to :comment
  belongs_to :user

  def self.thumbs_up_total
    self.where(vote_status: true).size
  end

  def self.thumbs_down_total
    self.where(vote_status: false).size
  end 
end
