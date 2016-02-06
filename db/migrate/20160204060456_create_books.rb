class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :book_name

      t.timestamps null: false
    end
  end
end
