class User < ApplicationRecord

  # enum user_types: {MNG: 0, QA: 1, DEV: 2}
  enum role: [:manager, :tester, :developer]
  after_initialize :set_default_role, :if => :new_record?


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Many to Many With Projects       
  has_many :user_projects       
  has_many :projects, through: :user_projects 

  #  Multiple Inheritance with Bugs
  has_many :created_bugs,    class_name: "Bug", foreign_key: "created_id"
  has_many :developed_bugs, class_name: "Bug", foreign_key: "developed_id"

  #comments
  has_many :comments

  #Votes
  has_many :votes

  # def upvote!(comment)
  #   self.votes.create!(comment_id: comment.id)
  # end

  # # destroys a heart with matching post_id and user_id
  # def downvote!(comment)
  #   upvote = self.votes.find_by_comment_id(comment.id)
  #   upvote.destroy!
  # end

  # # returns true of false if a post is hearted by user
  # def upvote?(comment)
  #   self.votes.find_by_comment_id(comment.id)
  # end

  # set Default User Callbacks
  private
    def set_default_role
      self.role ||= :manager
    end

end
