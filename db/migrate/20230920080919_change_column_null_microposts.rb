class ChangeColumnNullMicroposts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :microposts, :user_id, false
    change_column_null :microposts, :content, false
  end
end
