class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo
      t.text :bio
      t.string :post_counter
      t.string :integer

      t.timestamps
    end
  end
end
