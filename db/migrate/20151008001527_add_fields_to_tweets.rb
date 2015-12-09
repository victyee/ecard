class AddFieldsToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :user_id, :integer
    add_column :tweets, :body, :text
  end
end
