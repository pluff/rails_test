class Book < ActiveRecord::Base
  has_many :book_reviews, inverse_of: :book
  has_many :book_metrics, inverse_of: :book
end
