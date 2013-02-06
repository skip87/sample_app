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
    
    describe "for signed-in users" do 
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolr sit amet")
        sign_in user
        visit root_path
      end
      it "should render the user's feed " do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
      
      describe"follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do 
          other_user.follow!(user)
          visit root_path
        end
        
        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 follower", href:followers_user_path(user)) } 
      end
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
        click_link "Sign in"
        page.should have_selector 'title', text: full_title('Sign in')
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
