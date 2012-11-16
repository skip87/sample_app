require 'spec_helper'


describe "StaticPages" do
  
  include ApplicationHelper
  
  describe " Home page" do
    
    before { visit root_path}
    
    it "should have the h1 'Sample App'" do
      
      page.should have_selector('h1', :text => 'Sample App')
    end
    it "should have the right title " do
      
      page.should have_selector('title', :text => 'Ruby on Rails Tutorial Sample App | Home')
    end
    
  end
  
  describe "Help Page" do
    
    before { visit help_path}
    
    it "should have the h1 'Help' " do 
      
      page.should have_selector('h1', :text => 'Help')
    end
    it "should have the right title " do
      
      page.should have_selector('title', :text => 'Ruby on Rails Tutorial Sample App | Help')
    end
  end
  
  describe "About Page" do
    
    before { visit about_path}
    
    it "should have the h1 'About Us' " do 
      
      page.should have_selector('h1', :text => 'About Us')
    end
    it "should have the right title " do
      
      visit about_path
      page.should have_selector('title', :text => 'Ruby on Rails Tutorial Sample App | About Us')
    end
  end
  
  describe "Contact Page" do
    
    before { visit contact_path}
    
    it "should have the h1 'Contact' " do 
      
      page.should have_selector('h1', :text => 'Contact')
    end
    it "should have the right title " do
      
      page.should have_selector('title', :text => 'Ruby on Rails Tutorial Sample App | Contact')
    end
  end
  
  it "should have the right links on the layout" do
        visit root_path
        click_link "About"
        page.should have_selector 'title', text: full_title('About Us')
        click_link "Help"
        page.should have_selector 'title', text: full_title('Help')
        click_link "Contact"
        page.should have_selector 'title', text: full_title('Contact')
        click_link "Home"
        click_link "Sign up now!"
                       page.should have_selector 'title', text: full_title('Sign up')
        # click_link "sample app"
        #         page.should have_selector 'h1', text: full_title('Sample App')
      end
end
