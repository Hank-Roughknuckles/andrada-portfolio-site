require 'spec_helper'

describe "ApplicationLayout" do

  let(:user) { FactoryGirl.create :user }
  let(:showreel) { FactoryGirl.create :showreel }
  subject{ page }

  describe "Title on page" do
    before do
      visit root_path
    end

    it { should have_title 'Andrada' }
  end

  describe "Navbar" do
    before do
      login_as user
      visit root_path 
    end

    it { should have_content "Edit Navigation Bar" }
  end

  describe "Sign-in and Sign-out buttons" do
    describe "Sign-in button" do
      before do
        login_as user
        visit root_path 
      end

      it { should have_content "Sign Out" }
    end

    describe "Sign-out button" do
      before do
        login_as user
        visit root_path 
        click_link "Sign Out"
      end

      it { should have_content "Sign In" }
    end
  end
end
