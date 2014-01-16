require 'spec_helper'

describe "Contact Page" do
  let!(:user) { FactoryGirl.create :user }
  let!(:contact) { FactoryGirl.create :contact }
  subject { page }

  before do
    visit root_path
    click_link "Contact"
  end

  describe "Contact Page contents" do
    it { should have_content "Email" }
    it { should have_content "Vimeo" }

    describe "contents when signed out" do
      it { should_not have_content "Edit Contact Info" }
      it { should have_content "Sign In" }
    end

    describe "contents when signed in" do
      before do
        login_as user
        visit root_path
        click_link "Contact"
      end
      it { should have_content "Edit Contact Info" }
      it { should_not have_content "Sign In" }
      it { should have_content "Sign Out" }

      describe "Contact Edit Page" do
        before do
          click_link "Edit Contact Info"
        end
      end
    end
  end
end
