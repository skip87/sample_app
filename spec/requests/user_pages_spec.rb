require 'spec_helper'

describe "UserPages" do
  
  include ApplicationHelper
  subject { page }
  
  describe "signup page" do 
    before { visit signup_path }
    
    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text:full_title('Sign up')) }
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user)}
    before {visit user_path(user) }
    
    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
  
  describe "sign up" do 
    
    before { visit signup_path }
    let(:submit) {"Create my account"}
    
    describe "with invalid information " do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
        #ancient modele
        # old_count = User.count
        #         click_button submit
        #         new_count = User.count
        #         new_count.should == old_count
        
      end
    end
    
    describe " After submission " do
      before { click_button submit }
      
      it { should have_selector('title', text: 'Sign up') }
      it { should have_content('error')}
      it { should_not have_content('Password digest') }#error Password digest .
    end
    
    describe "with valid information " do 
      before do
        fill_in "Name",         with: "example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation",     with: "foobar"
      end
        
      it "should create a user " do 
        expect { click_button submit }.to change(User, :count).by(1)
        #ancient modele
        # old_count = User.count
        #        fill_in "Name",         with: "example User"
        #        fill_in "Email",        with: "user@example.com"
        #        fill_in "Password",     with: "foobar"
        #        fill_in "Confirmation",     with: "foobar"
        #        click_button submit
        #        new_count = User.count
        #        new_count.should == old_count + 1  
      end
      describe "after saving a user " do 
      before { click_button submit }
      let(:user) { User.find_by_email("user@example.com")}
        
        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.allert.alert-success', text: 'Welcome')}
      end
    end
  end
  
end
