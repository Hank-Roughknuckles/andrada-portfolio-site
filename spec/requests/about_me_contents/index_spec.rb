require 'spec_helper'

def add_content
  visit edit_about_me_content_path about_me_content.id

  fill_in "Header", with: "Test Header"
  fill_in "Description", with: "Test Description"
  fill_in "Button Title", with: "Test Button Title"

  click_button "Save"
end

describe "AboutMePages" do

  let(:about_me_content) { FactoryGirl.create :about_me_content }
  let(:nav_item) { FactoryGirl.create :nav_item }
  let(:user) { FactoryGirl.create :user }

  subject{ page }

  before do
    login_as user
  end

  describe "'About Me' index Page" do
    before do
      add_content
      visit root_path
    end

    it { should have_title "About Me" }
    it { should have_content "Edit" }

  end
end
