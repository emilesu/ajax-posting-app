class RemoveColeectionTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :collections, :user_id
    remove_column :collections, :post_id
  end
end
