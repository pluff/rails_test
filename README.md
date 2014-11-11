### HOW TO REPRODUCE THE BUG

* Clone repo, install gems create db
* Run `rake db:setup` for initial seeds
* Run `rails c` and try to enter this code:

```ruby
b = Book.first; ['m1','m2'].each { |name| b.book_metrics.create!(name: name) }
```

And you will see something like this:

```
rails_test git:(bug_report/duplicated_objects) ✗ be rails c
Loading development environment (Rails 4.1.7)
2.1.2 :001 > b = Book.first; ['m1','m2'].each { |name| b.book_metrics.create!(name: name) }
  Book Load (0.7ms)  SELECT  "books".* FROM "books"   ORDER BY "books"."id" ASC LIMIT 1
   (0.1ms)  BEGIN
  SQL (0.8ms)  INSERT INTO "book_metrics" ("book_id", "created_at", "name", "updated_at") VALUES (1, '2014-11-11 19:19:30.596381', 'm1', '2014-11-11 19:19:30.596381') RETURNING "id"  [["book_id", 1], ["created_at", Tue, 11 Nov 2014 19:19:30 UTC +00:00], ["name", "m1"], ["updated_at", Tue, 11 Nov 2014 19:19:30 UTC +00:00]]
  BookReview Load (0.3ms)  SELECT "book_reviews".* FROM "book_reviews"  WHERE "book_reviews"."book_id" = 1  [["book_id", 1]]
  BookReviewMetric Load (0.3ms)  SELECT "book_review_metrics".* FROM "book_review_metrics"  WHERE "book_review_metrics"."book_review_id" = 1  [["book_review_id", 1]]
METRIC IDS IN RECALC METHOD!
  BookMetric Load (0.3ms)  SELECT "book_metrics".* FROM "book_metrics"  WHERE "book_metrics"."book_id" = 1  [["book_id", 1]]
1
===============================================================
  SQL (0.5ms)  INSERT INTO "book_review_metrics" ("book_metric_id", "book_review_id", "created_at", "score", "updated_at") VALUES (1, 1, '2014-11-11 19:19:30.617139', 1, '2014-11-11 19:19:30.617139') RETURNING "id"  [["book_metric_id", 1], ["book_review_id", 1], ["created_at", Tue, 11 Nov 2014 19:19:30 UTC +00:00], ["score", 1], ["updated_at", Tue, 11 Nov 2014 19:19:30 UTC +00:00]]
   (0.3ms)  COMMIT
   (0.1ms)  BEGIN
  SQL (0.2ms)  INSERT INTO "book_metrics" ("book_id", "created_at", "name", "updated_at") VALUES (1, '2014-11-11 19:19:30.619711', 'm2', '2014-11-11 19:19:30.619711') RETURNING "id"  [["book_id", 1], ["created_at", Tue, 11 Nov 2014 19:19:30 UTC +00:00], ["name", "m2"], ["updated_at", Tue, 11 Nov 2014 19:19:30 UTC +00:00]]
  SQL (0.3ms)  DELETE FROM "book_review_metrics" WHERE "book_review_metrics"."id" = 1  [["id", 1]]
METRIC IDS IN RECALC METHOD!
1
1
===============================================================
  SQL (0.2ms)  INSERT INTO "book_review_metrics" ("book_metric_id", "book_review_id", "created_at", "score", "updated_at") VALUES (1, 1, '2014-11-11 19:19:30.621902', 1, '2014-11-11 19:19:30.621902') RETURNING "id"  [["book_metric_id", 1], ["book_review_id", 1], ["created_at", Tue, 11 Nov 2014 19:19:30 UTC +00:00], ["score", 1], ["updated_at", Tue, 11 Nov 2014 19:19:30 UTC +00:00]]
  SQL (0.6ms)  INSERT INTO "book_review_metrics" ("book_metric_id", "book_review_id", "created_at", "score", "updated_at") VALUES (1, 1, '2014-11-11 19:19:30.633508', 1, '2014-11-11 19:19:30.633508') RETURNING "id"  [["book_metric_id", 1], ["book_review_id", 1], ["created_at", Tue, 11 Nov 2014 19:19:30 UTC +00:00], ["score", 1], ["updated_at", Tue, 11 Nov 2014 19:19:30 UTC +00:00]]
PG::UniqueViolation: ERROR:  duplicate key value violates unique constraint "index_book_review_metrics_on_book_metric_id_and_book_review_id"
DETAIL:  Key (book_metric_id, book_review_id)=(1, 1) already exists.
: INSERT INTO "book_review_metrics" ("book_metric_id", "book_review_id", "created_at", "score", "updated_at") VALUES (1, 1, '2014-11-11 19:19:30.633508', 1, '2014-11-11 19:19:30.633508') RETURNING "id"
   (0.1ms)  ROLLBACK
ActiveRecord::RecordNotUnique: PG::UniqueViolation: ERROR:  duplicate key value violates unique constraint "index_book_review_metrics_on_book_metric_id_and_book_review_id"
DETAIL:  Key (book_metric_id, book_review_id)=(1, 1) already exists.
```

Check the debug infor about metric ids! It's 2 same values.
