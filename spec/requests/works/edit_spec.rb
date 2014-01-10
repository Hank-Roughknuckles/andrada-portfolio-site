require 'spec_helper'

describe "WorksEditPages" do

  let!(:user) { FactoryGirl.create :user }
  let!(:works1) { FactoryGirl.create :works }
  let!(:works2) { FactoryGirl.create :works }

  subject { page }

  before do
    login_as user
    visit works_path
    click_link "edit_work_#{works1.id}"
  end

  describe "Edit page layout" do
    it { should have_content works1.header }
    it { should have_content works1.description }
    it { should have_xpath "//iframe" }

    it { should have_field "Video link" }
    it { should have_field "Header" }
    it { should have_field "Description" }
  end

  describe "The Editing Process" do
    describe "With an invalid video link" do
      before do
        fill_in "Video link", with: "www.google.com"
        click_button "Save"
      end

      it { should have_content "Invalid video link" }
    end

    describe "With a valid video link" do
      before do
        fill_in "Video link", with: "https://vimeo.com/83571847"
        fill_in "Header", with: "Test Header"
        fill_in "Description", with: "Test Description"
        click_button "Save"
      end

      it { should have_content "Test Header" }
      it { should have_content "Test Description" }
      it { should have_xpath "//iframe" }
    end
  end
end
