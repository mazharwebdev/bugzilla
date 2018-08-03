class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :bug

  #Votes
  has_many :votes
end
