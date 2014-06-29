When(/^I enter "(.*?)" in the new item field$/) do |arg1|
  within '#new_item' do
    fill_in 'Content', with: 'my sweet list item'
  end
end
