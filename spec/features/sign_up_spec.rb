# require 'rails_helper'
#
# feature 'sign_up', %Q{
#   As an unathenticated user
#   I want to sign up
#   So that I can get full access to the the web app
# } do
#
#   # ACCEPTANCE CRITERIA
#   # * I must specify a valid email address
#   # * I must specify a password, and confirm that password
#   # * If I do not perform the above, I get an error message
#   # * If I specify valid info, I register my account and am authenticated
#
#
#
#   scenario 'specify valid and required information' do
#     visit root_path
#     click_link 'Sign Up'
#     fill_in 'Full Name', with: 'Jon Snow'
#     fill_in 'Email', with: 'gameofthrones@got.com'
#     fill_in 'user_password', with: 'password'
#     fill_in 'Password Confirmation', with: 'password'
#     click_button 'Sign Up'
#     expect(page).to have_content("Sign Out")
#   end
#
#
#   scenario 'required information is not supplied' do
#     visit root_path
#     click_link 'Sign Up'
#     click_button 'Sign Up'
#
#     expect(page).to have_content("can't be blank")
#     expect(page).to_not have_content("Sign Out")
#   end
#
#   scenario 'password confirmation does not match confirmation' do
#     visit root_path
#     click_link 'Sign Up'
#     fill_in 'Full Name', with: 'Jon Snow'
#     fill_in 'Email', with: 'gameofthrones@got.com'
#     fill_in 'user_password', with: 'password'
#     fill_in 'Password Confirmation', with: 'differentpassword'
#     click_button 'Sign Up'
#
#
#     expect(page).to have_content("doesn't match Password")
#     expect(page).to_not have_content("Sign Out")
#   end
# end
