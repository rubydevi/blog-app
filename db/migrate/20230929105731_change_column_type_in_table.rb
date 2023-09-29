class ChangeColumnTypeInTable < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :post_counter, :integer, using: 'post_counter::integer'
  end
end
