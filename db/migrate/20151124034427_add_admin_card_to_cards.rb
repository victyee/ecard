class AddAdminCardToCards < ActiveRecord::Migration
  def change
    add_column :cards, :admin_card, :boolean
  end
end
