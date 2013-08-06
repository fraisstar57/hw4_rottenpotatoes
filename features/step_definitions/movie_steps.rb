# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
	Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  regexp = /#{e1}.*#{e2}/m
  page.body.should =~ regexp
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I print the page body/ do
  puts "AND THE PAGE BODY IS..." + page.body.to_s
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.to_s.split(',').each do |r| 
  r = r.gsub(/\s+/, "")
  #puts "rating: " + r + uncheck.to_s
  @ratingsTest = "ratings_"
  @checkboxField = @ratingsTest+r  
  #web_steps %Q{I #{uncheck}check #{@checkboxField}}
  #check(@ratingsTest+r)
	
  if(uncheck == "un")
	#puts "rating: " + r + uncheck.to_s
	#WithinHelpers step %Q{I #{uncheck}check #{r} }
	#page.check(@checkboxField.to_s)
    #@field = find_field(@checkboxField)
	#puts @field	
	#debugger
	step %Q{I uncheck "#{r}"}
    step %Q{the "#{r}" checkbox should not be checked}
  else 
	#puts "rating: " + r + uncheck.to_s
    #WithinHelpers step %Q{I #{uncheck}check #{r} }
	#page.uncheck(@checkboxField.to_s)
    #@field = find_field(@checkboxField)
	#puts @field
	step %Q{I check "#{r}"}
    step %Q{the "#{r}" checkbox should be checked}
  end
  
  end
end
