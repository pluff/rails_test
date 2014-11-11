class BookMetric < ActiveRecord::Base
  belongs_to :book, inverse_of: :book_metrics
  has_many :book_review_metrics, inverse_of: :book_metric

  after_save :recalc_all_reviews!

  def recalc_all_reviews!
    book.book_reviews.each &:recalc_metrics!
  end
end
