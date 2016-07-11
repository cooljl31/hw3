
# Add a declarative step here for populating the DB with movies.
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
   Movie.create movie
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /^I should see "(.*)" before "(.*)"$/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  page.body.should match /#{e1}.*#{e2}/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(", ").each { |ratings| uncheck ? uncheck("ratings_#{ratings}") : check("ratings_#{ratings}") }
end

 When(/^I click on "Refresh"$/) do
  click_on "Refresh"
end

 # Make sure that all the movies in the app are visible in the table
# Make sure that all the movies in the app are not visible in the table
 # Make sure that i am on the movie path
 Then /^I should be on the movie page$/ do
     visit movies_path
 end
Then /I should see all of the movies$/ do
  page.all('table#movies tbody tr').count.should == Movie.count
end

Then /I should not see all of the movies$/ do
  page.should have_css("table#movies tbody tr")
end
