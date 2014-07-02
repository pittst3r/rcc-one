Given(/^I have "(\d+)" items?$/) do |kount|
  @items = create_list :item, kount.to_i
end

When(/^I add a new item containing "(.*?)"$/) do |content|
  @new_item = content
  fill_in 'new-item', with: content
  page.driver.execute_script("var e = $.Event('keydown', { keyCode: 13 }); $('body').trigger(e);")
end

Then(/^I should see my new item$/) do
  has_content?(@new_item)
end

Then(/^I should see my items?$/) do
  @items.each do |i|
    has_content? i.content
  end
end
