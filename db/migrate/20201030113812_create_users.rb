class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :reset_password_token, default: nil
      t.datetime :reset_password_token_expires_at, default: nil
      t.jsonb :meta, null: false, default: {}

      t.timestamps

      t.index :email, unique: true
      t.index :reset_password_token
    end
  end
end
