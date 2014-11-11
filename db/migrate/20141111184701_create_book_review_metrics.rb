class CreateBookReviewMetrics < ActiveRecord::Migration
  def change
    create_table :book_review_metrics do |t|
      t.belongs_to :book_metric, null: false
      t.belongs_to :book_review, null: false
      t.integer :score, null: false
      t.timestamps
    end
    add_index :book_review_metrics, [:book_metric_id, :book_review_id], unique: true
  end
end
