class CreateFollowLists < ActiveRecord::Migration[6.0]
  def change
    create_table :follow_lists do |t|
      t.references :user, null: false, foreign_key: { to_table: 'users' }
      t.references :followed_user, null: false, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
