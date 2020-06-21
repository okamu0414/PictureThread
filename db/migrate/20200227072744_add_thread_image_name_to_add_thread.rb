class AddThreadImageNameToAddThread < ActiveRecord::Migration[5.0]
  def change
    add_column :Add_Threads, :thread_image_name, :string
  end
end
