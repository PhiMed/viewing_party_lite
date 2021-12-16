# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user register (new) page' do
  it 'can create a new user' do
    visit '/register'

    fill_in 'name', with: 'Steve'
    fill_in 'email', with: 'steve@steve.com'
    fill_in 'password', with: '1234'
    fill_in 'password_confirmation', with: '1234'


    click_button

    expect(current_path).to eq("/users/#{User.all.last.id}")
    expect(page).to have_content('Steve')
  end

  it 'shows a specific error flash message when fields are missing' do
    visit '/register'

    click_button

    expect(page).to have_content("Name can't be blank, Email can't be blank, Password can't be blank")

    visit '/register'
    fill_in 'name', with: 'Steve'

    click_button

    expect(page).to have_content("Email can't be blank, Password can't be blank")

    visit '/register'
    fill_in 'name', with: 'Steve'
    fill_in 'email', with: 'steve@steve.com'

    click_button

    expect(page).to have_content("Password can't be blank")

  end

  it 'errors when passwords dont match' do
    visit '/register'

    fill_in 'name', with: 'Steve'
    fill_in 'email', with: 'steve@steve.com'
    fill_in 'password', with: '1234'
    fill_in 'password_confirmation', with: 'I want to be a triangle'

    click_button

    expect(current_path).to eq("/register")
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it 'errors when email is not unique' do
    visit '/register'

    fill_in 'name', with: 'Steve'
    fill_in 'email', with: 'steve@steve.com'
    fill_in 'password', with: '1234'
    fill_in 'password_confirmation', with: '1234'

    click_button

    visit '/register'

    fill_in 'name', with: 'Paul'
    fill_in 'email', with: 'steve@steve.com'
    fill_in 'password', with: '5678'
    fill_in 'password_confirmation', with: '5678'

    click_button

    expect(page).to have_content("Email has already been taken")
  end
end
