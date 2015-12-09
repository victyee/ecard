class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
    	t.references index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
