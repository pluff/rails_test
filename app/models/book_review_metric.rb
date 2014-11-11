class BookReviewMetric < ActiveRecord::Base
  belongs_to :book_review, inverse_of: :book_review_metrics
  belongs_to :book_metric, inverse_of: :book_review_metrics
end
