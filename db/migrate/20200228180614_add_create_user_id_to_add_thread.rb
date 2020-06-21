class AddCreateUserIdToAddThread < ActiveRecord::Migration[5.0]
  def change
    add_column :add_threads ,:create_user_id, :integer
  end
end
