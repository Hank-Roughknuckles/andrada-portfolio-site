require 'spec_helper'

describe "WorksPages" do
  let!(:user) { FactoryGirl.create :user }
  let!(:works1) { FactoryGirl.create :works }
  let!(:works2) { FactoryGirl.create :works }

  subject { page }

  describe "The index page" do
    describe "The page layout" do
      describe "when not signed in" do
        before do
          logout :user
          visit works_path
        end

        it { should have_content "Sign In" }
      end

      describe "when signed in" do
        before do
          login_as user
          visit works_path
        end

        it { should have_content "Sign Out" }
        
        describe "The admin edit table" do
          it { should have_content "Video Thumbnail" }
          it { should have_content "Video Link" }
          it { should have_content "Header" }
          it { should have_content "Description" }

          it { should have_link "Add New Work" }
          it { should have_xpath "//table/tr/td[text()=\"#{works1.header}\"]" }
          it { should have_xpath "//table/tr/td[text()=\"#{works1.description}\"]" }
          it { should have_xpath "//table/tr/td[text()=\"#{works1.video_link}\"]" }
          it { should have_xpath "//table/tr/td/iframe" }
          it { should have_xpath "//table/tr/td[text()=\"#{works2.header}\"]" }
          it { should have_xpath "//table/tr/td[text()=\"#{works2.description}\"]" }
          it { should have_xpath "//table/tr/td[text()=\"#{works2.video_link}\"]" }
          it { should have_xpath "//table/tr/td/a[text()=\"Edit\"]" }
        end
      end
    end
  end

  describe "The Edit Page" do
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
end
