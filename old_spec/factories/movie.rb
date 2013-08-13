#spec/factories/movie.rb

FactoryGirl.define do
  factory :movie do
	  id 1
	  title "Star Wars"
	  rating "PG"
	  director "George Lucas"
	  release_date "1977-05-25"
  end
end
