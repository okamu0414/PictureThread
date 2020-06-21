class CreateAddThreads < ActiveRecord::Migration[5.0]
  def change
    create_table :add_threads do |t|
      t.string :thread_name
      t.string :user_name
      t.datetime :limit_time

      t.timestamps
    end
  end
end
