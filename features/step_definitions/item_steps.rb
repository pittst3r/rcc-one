Given(/^I have "(\d+)" items?$/) do |kount|
  @items = create_list :item, kount.to_i
end

Then(/^I should see my items?$/) do
  @items.each do |i|
    expect(page).to have_content(i.content)
  end
end
