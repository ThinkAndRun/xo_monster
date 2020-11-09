class CreateXoSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :xo_sessions do |t|
      t.string :slug, null: false
      t.integer :x_user_id, null: false
      t.integer :o_user_id
      t.integer :winner_id
      t.integer :loser_id
      t.jsonb :settings, null: false, default: {}
      t.jsonb :steps, null: false, default: []
      t.datetime :started_at
      t.datetime :last_step_at

      t.timestamps

      t.index :slug, unique: true
      t.index :x_user_id
      t.index :o_user_id
      t.index :winner_id
      t.index :loser_id
    end
  end
end
