require 'rails_helper'

RSpec.describe 'registered users login in' do
  describe "When I visit the landing page - Happy Path" do
    it "has a link for 'Log In'" do
      visit '/'

      expect(page).to have_link('Log In')
    end

    it "when I click on the link, I am take to the log in page where I input my unique email and password" do
      visit '/'

      click_link('Log In')

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
    end

    it 'when I enter a valid email and password, I am taked to my dashboard' do
      user = User.create(name: 'Tom', email: 'tom@aol.com', password: 'test123')
      visit '/'

      click_link('Log In')

      fill_in("Email", with: user.email)
      fill_in("Password", with: user.password)

      click_on("Log In")

      expect(current_path).to eq(dashboard_path)
    end
  end

  describe "When I visit the landing page - Sad Path" do
      it 'when I enter an invalid email and password, I redirected back to the login page and I see a message telling me my credentials are incorrect' do
        user = User.create(name: 'Tom', email: 'tom@aol.com', password: 'test123')
        visit '/'
  
        click_link('Log In')
  
        fill_in("Email", with: user.email)
        fill_in("Password", with: 'test321')
  
        click_on("Log In")
  
        expect(current_path).to eq('/')
        expect(page).to have_content('Invalid Credentials')
      end
    end

  describe 'As a logged in user When I visit the landing page' do
    it 'I no longer see a link to log in or create and account' do
      user = User.create(name: 'Tom', email: 'tom@aol.com', password: 'test123')
        visit '/'
  
        click_link('Log In')
  
        fill_in("Email", with: user.email)
        fill_in("Password", with: 'test123')
  
        click_on("Log In")
  
        visit '/'

        expect(page).to_not have_link("Log In")
        expect(page).to_not have_button("Create a New User")
    end

    it 'I see a link to Log Out' do
      user = User.create(name: 'Tom', email: 'tom@aol.com', password: 'test123')
      visit '/'
  
        click_link('Log In')
  
        fill_in("Email", with: user.email)
        fill_in("Password", with: 'test123')
  
        click_on("Log In")
  
        visit '/'

        expect(page).to have_link("Log Out")
    end

    it 'When I click the link to Log Out Im taken to the landing page And I can see that the Log Out link has changed back to a Log In link' do
      user = User.create(name: 'Tom', email: 'tom@aol.com', password: 'test123')
      visit '/'

      click_link('Log In')

      fill_in("Email", with: user.email)
      fill_in("Password", with: 'test123')

      click_on("Log In")

      visit '/'
      click_link("Log Out")

      expect(current_path).to eq('/')

      expect(page).to have_link("Log In")
      expect(page).to have_button("Create a New User")
    end
  end
end 
