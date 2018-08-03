class Bug < ApplicationRecord
  belongs_to :project
  
  # Multiple Foriegn Keys
  belongs_to :creater,  class_name: "User", foreign_key: "created_id"
  belongs_to :developer, class_name: "User", foreign_key: "developed_id"
end
