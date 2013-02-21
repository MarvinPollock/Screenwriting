Given /^I am at page users$/ do
  all('h1').each do |h|
    h.to_s.match("CXS")
  end
end

When /^I click at Projects$/ do
  #pending # express the regexp above with the code you wish you had
end

Then /^I should be redirected to Projects$/ do
  ''.nil?
end