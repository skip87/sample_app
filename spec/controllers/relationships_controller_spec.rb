require 'spec_helper'

describe RelationshipsController do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  
  before { sign_in user }
  describe "creating a relationship with Ajax" do
    
    it "should increment the Relationship count" do
      expect do
         xhr :post, :create, relationship: { followed_id: other_user.id }
       end.to change(Relationship, :count).by(1)
      end
      
      it "should respond with succes" do
        xhr :post, :create, relationship: { followed_id: other_user.id }
        response.should be_succes
    end
    
  end
  
  
  describe "destroying a relationship with Ajax" do
     
    before { user.follow!(other_user) }
    let(:relationship) {user.relationships.find_by_followed_id(other_user) }
    
    it "should increment the Relationship count" do
      expect do
         xhr :delete, :destroy, id: relationship.id 
       end.to change(Relationship, :count).by(-1)
      end
    
      
      it "should respond with succes" do
        xhr :delete, :destroy, id: relationship.id
        response.should be_succes
    end

    
  end
  
end