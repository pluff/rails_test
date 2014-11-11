class CreateBookReviews < ActiveRecord::Migration
  def change
    create_table :book_reviews do |t|
      t.belongs_to :book, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
