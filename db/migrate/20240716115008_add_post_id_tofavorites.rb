class AddPostIdTofavorites < ActiveRecord::Migration[6.1]
  def change
    add_column :favorites, :user_id, :integer,null: false
    add_column :favorites, :post_id, :integer,null: false
  end
end
