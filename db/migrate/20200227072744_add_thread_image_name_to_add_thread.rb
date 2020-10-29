class AddThreadImageNameToAddThread < ActiveRecord::Migration[5.0]
  def change
    add_column :add_threads, :thread_image_name, :string
  end
end
