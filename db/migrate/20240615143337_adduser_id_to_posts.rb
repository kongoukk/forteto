class AdduserIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :user_id, :integer,null: false
  end
end
