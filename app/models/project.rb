class Project < ApplicationRecord
  validates :title, :description, presence: true
  #User and Project Many to Many
  has_many :user_projects
  has_many :users, through: :user_projects
  # relation to bugs
  has_many :bugs 
end
