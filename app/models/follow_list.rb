class FollowList < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :followed_user, class_name: "User"
end
