class AddUserIdTocomments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :user_id, :integer,null: false
  end
end
