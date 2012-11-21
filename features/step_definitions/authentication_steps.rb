Given /^a user visits signin page$/ do
  visit signin_path
end

When /^he submit invalid signin information$/ do
  click_button "Sign in"
end

Then /^he should see an error message$/ do
  page.should have_selector('div.alert.alert-error')
end


Given /^the user has an account$/ do
  @user = User.create(name: "example User", email: "euser@example.com", 
                      password: "foobar", password_confirmation: "foobar")
end

Given /^the user submits valid signin information$/ do
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.passsword
  click_button "Sign in"
end

Then /^he should see his profile page$/ do
  page.should have_selector('title', text: @user.name)
end

Then /^he should see a signout link$/ do
  page.should have_link('Sign out', href: signout_path)
end
