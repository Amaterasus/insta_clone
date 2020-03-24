class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.integerfollowee_id :follower_id

      t.timestamps
    end
  end
end
