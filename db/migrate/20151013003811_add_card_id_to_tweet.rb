class AddCardIdToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :card_id, :integer
  end
end
