class AddFieldsToCard < ActiveRecord::Migration
  def change
    add_column :cards, :hashtag, :string
    add_column :cards, :date, :string
    add_column :cards, :copyright, :string
  end
end
