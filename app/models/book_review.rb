class BookReview < ActiveRecord::Base
  has_many :book_review_metrics, inverse_of: :book_review
  belongs_to :book, inverse_of: :book_reviews

  after_create :recalc_metrics!

  def recalc_metrics!
    book_review_metrics.destroy_all
    puts "METRIC IDS IN RECALC METHOD!"
    puts book.book_metrics.map(&:id)
    puts '==============================================================='
    book.book_metrics.each do |metric|
      book_review_metrics.create!(book_metric: metric, score: 1)
    end
  end
end
