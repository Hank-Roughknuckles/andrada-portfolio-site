require 'spec_helper'

describe "ShowreelPages" do
  let(:showreel) { FactoryGirl.create :showreel }
  let(:user) { FactoryGirl.create :user }
  subject { page }

  before do
    visit showreel_path showreel.id
  end

  describe "Showreel nav button" do
    before do
      visit root_path
      click_link "Showreel"
    end

    it { should have_title "Showreel" }
  end
  
  describe "show page contents" do
    before do
      visit showreel_path showreel.id
    end

    it { should have_title "Showreel" }
    it { should have_content showreel.header }
    it { should have_content showreel.description }

    describe "The Edit Button" do
      describe "when not logged in" do
        it { should_not have_content "Edit Content" }
      end

      describe "when logged in" do
        before do
          login_as user
          visit showreel_path showreel.id
        end

        it { should have_content "Edit Content" }
        
      end
    end
  end
  
end
