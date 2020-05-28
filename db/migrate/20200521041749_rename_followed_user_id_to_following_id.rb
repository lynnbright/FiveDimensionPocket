class RenameFollowedUserIdToFollowingId < ActiveRecord::Migration[6.0]
  def change
    rename_column :follow_lists, :followed_user_id, :following_id
  end
end
