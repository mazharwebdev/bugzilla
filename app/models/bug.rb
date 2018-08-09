class Bug < ApplicationRecord
  enum bugType: [:feature, :bug]

  FEATURE_AR = ["new","started","completed"]
  BUG_AR = ["new","started","resolved"]

  belongs_to :project
  validates :screenshot, :title, :deadline,:bug_type,:status, :project_id, :created_id, :developed_id, presence: true
  validates :title, uniqueness: true  
  # Multiple Foriegn Keys
  belongs_to :creater,  class_name: "User", foreign_key: "created_id"
  belongs_to :developer, class_name: "User", foreign_key: "developed_id"

  #comments
  has_many :comments, dependent: :destroy

  mount_uploader :screenshot, ScreenshotUploader
end
