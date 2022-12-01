class RemoveViewShowFromFavorites < ActiveRecord::Migration[6.1]
  def change
    remove_column :favorites, :view_show, :integer
  end
end
