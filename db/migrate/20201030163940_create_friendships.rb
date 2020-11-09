class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.integer :sender_user_id, null: false
      t.integer :receiver_user_id, null: false
      t.boolean :confirmed, null: false, default: false

      t.timestamps

      t.index [:sender_user_id, :receiver_user_id], unique: true
    end
  end
end
