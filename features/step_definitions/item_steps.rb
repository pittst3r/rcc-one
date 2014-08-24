Given(/^I have "(.*?)" items$/) do |kount|
  @items = create_list :item, kount.to_i
end

Then(/^I should see my items$/) do
  @items.each do |i|
    has_selector? "input[value='#{i}']"
  end
end
