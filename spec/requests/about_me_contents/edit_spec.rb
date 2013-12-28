require 'spec_helper'

describe "EditAboutMeContents" do

  subject{ page }
  let(:about_me_content) { FactoryGirl.create :about_me_content }
  let(:nav_item) { FactoryGirl.create :nav_item }
  let(:user) { FactoryGirl.create :user }

  before do
    login_as user
  end

  describe "Edit Page" do
    before do 
      visit edit_about_me_content_path about_me_content.id
    end

    describe "page contents" do
      it { should have_content "image" }
      it { should have_field "about_me_content[header]" }
      it { should have_field "about_me_content[description]" }
      it { should have_field "about_me_content[button_title]" }
      it { should have_link "Sign Out" }
      it { should_not have_link "Sign In" }

      describe "field contents" do
        it { should have_xpath "//input[@value=\"#{about_me_content.header}\"]" }
        it { should have_content about_me_content.description }
        it { should have_xpath "//input[@value=\"#{about_me_content.button_title}\"]" }
      end
    end

    describe "Updating the text on a slide" do
      before do
        fill_in "Header", with: "Test Header"
        fill_in "Description", with: "Test Description"
        fill_in "Button Title", with: "Test Button Title"

        click_button "Save"
      end

      it { should have_content "Test Header" }
      it { should have_content "Test Description" }
      it { should have_content "Test Button Title" }
    end

  end
end
