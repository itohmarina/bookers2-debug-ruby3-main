class AddViewShowToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_column :favorites, :view_show, :integer
  end
end
