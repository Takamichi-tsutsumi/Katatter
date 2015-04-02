class ChangeColumnImageAddDefault < ActiveRecord::Migration
  def change
    change_column_default :users, :image, "egg.png"
  end
end
