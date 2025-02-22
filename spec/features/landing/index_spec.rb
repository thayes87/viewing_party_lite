require 'rails_helper'

RSpec.describe 'landing page', type: :feature do
  describe 'title of application' do
    it 'has a title at the top of the page' do
      visit '/'

      expect(page).to have_content('Viewing Party Lite')
    end
  end

  describe 'button to create a new user' do
    it 'has a button to create a new user' do
      visit '/'

      expect(page).to have_button('Create a New User')
      click_button('Create a New User')
      expect(current_path).to eq('/register')
    end
  end

  describe 'list of existing users' do
    before :each do
      @user1 = User.create!(name: 'Erin', email: 'epintozzi@turing.edu', password: "test")
      @user2 = User.create!(name: 'Mike', email: 'mike@turing.edu', password: "test")
      @user3 = User.create!(name: 'Meg', email: 'mstang@turing.edu', password: "test")
    end

    xit 'has a list of existing user which links to the users dashboard' do
      visit '/'


      within '#existing_users' do
        expect(page).to have_content("epintozzi@turing.edu")
        expect(page).to have_content("mike@turing.edu")
        expect(page).to have_content("mstang@turing.edu")
      end

      # within '#existing_users' do
      #   click_link("epintozzi@turing.edu's Dashboard")
      # end

      # expect(current_path).to eq(dashboard_path)
    end
  end

  describe ' link to go back to landing page' do
    it 'has a link to go back to the landing page' do
      visit '/'

      expect(page).to have_link('Home')
      click_link('Home')
      expect(current_path).to eq('/')
    end
  end

  describe 'as a visitor when I visit the landing page' do 
    it 'I do not see the section of the page that lists existing users' do 
      @user1 = User.create!(name: 'Erin', email: 'epintozzi@turing.edu', password: "test")
      @user2 = User.create!(name: 'Mike', email: 'mike@turing.edu', password: "test")
      @user3 = User.create!(name: 'Meg', email: 'mstang@turing.edu', password: "test")

      visit '/'

      expect(page).to_not have_content("epintozzi@turing.edu")
      expect(page).to_not have_content("mike@turing.edu")
      expect(page).to_not have_content("mstang@turing.edu")

    end
  end

  describe 'as a registerd user when I visit the landing page' do
    it 'I see the section of the page that lists existing users' do 
      user = User.create(name: 'Tom', email: 'tom@aol.com', password: 'test123')
      @user1 = User.create!(name: 'Erin', email: 'epintozzi@turing.edu', password: "test")
      @user2 = User.create!(name: 'Mike', email: 'mike@turing.edu', password: "test")
      @user3 = User.create!(name: 'Meg', email: 'mstang@turing.edu', password: "test")

      visit '/'

      click_link('Log In')

      fill_in("Email", with: user.email)
      fill_in("Password", with: 'test123')

      click_on("Log In")

      visit '/'

      within '#existing_users' do
        expect(page).to have_content("epintozzi@turing.edu")
        expect(page).to have_content("mike@turing.edu")
        expect(page).to have_content("mstang@turing.edu")
      end
    end
  end

  describe 'as a visitor when I visit the landing page' do 
    it 'And then try to visit /dashboard I remain on the landing page And I see a message telling me that I must be logged in or registered to access my dashboard' do
      visit '/'

      visit 'dashboard'

      expect(current_path).to eq('/')
      expect(page).to have_content("You must be logged in or registered")
    end
  end
end