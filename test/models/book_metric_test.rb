#require 'test_helper'

class BookMetricTest < ActiveSupport::TestCase
  test 'it can create 3 metrics at one time' do
    book = Book.create!(name: 'test book')
    book.book_reviews.create!(name: 'test review')

    ['metric 1', 'metric 2', 'metric 3'].each do |name|
      book.book_metrics.create! name: name
    end
    #Test finished!
    assert true
  end
  # test "the truth" do
  #   assert true
  # end
end
