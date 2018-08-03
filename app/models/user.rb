class User < ApplicationRecord

  enum user_type: {MNG: 0, QA: 1, DEV: 2}

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

  def bugs
    Bugs.where("created_id = ? OR developed_id = ?", self.id, self.id)
  end
end
