class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :image_name
      t.string :user_id
      t.string :thread_name

      t.timestamps
    end
  end
end
