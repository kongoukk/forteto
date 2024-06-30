class AddUserIdToPostImages < ActiveRecord::Migration[6.1]
  def change
    add_column :post_images, :user_id, :integer,null: false
    add_index :post_images, :user_id
  end
end
