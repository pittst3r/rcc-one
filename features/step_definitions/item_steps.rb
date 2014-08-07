Given(/^I have "(\d+)" items?$/) do |kount|
  @itemss = create_list(:item, kount.to_i).map &:description
  @itemss.each { |i| puts i }
end

When(/^I add a new item containing "(.*?)"$/) do |content|
  @new_item = content
  all('input').last.set(content)
  page.driver.execute_script("$('input').last().trigger($.Event('keypress', { which: 13 }));")
end

Then(/^I should see my new item$/) do
  puts @new_item
  has_selector? "input[value='#{@new_item}']"
end

Then(/^I should see my items?$/) do
  @itemss.each do |i|
    puts find("input[value='#{i}']").value
    has_selector? "input[value='#{i}']"
  end
end
