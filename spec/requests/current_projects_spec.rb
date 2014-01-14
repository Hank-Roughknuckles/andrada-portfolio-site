require 'spec_helper'

describe "CurrentProjectsPages" do
  let!(:current_project_1) { FactoryGirl.create :current_project }
  let!(:current_project_2) { FactoryGirl.create :current_project }
  let!(:user) { FactoryGirl.create :user }

  subject { page }

  describe "Index page" do
    before do
      visit current_projects_path
    end

    it { should have_title "Current Projects" }

    describe "when not logged in" do
      it { should_not have_content "Edit Content" }
    end

    describe "when logged in" do
      before do
        login_as user
        visit current_projects_path
      end
      it { should have_xpath "//table//td/a[text()=\"Edit\"]" }
      it { should have_content "Add Project" }
      it { should have_button "Delete" }

      describe "The Add Page" do
        before do
          click_link "Add Project"
        end

        it { should have_field "Header" }
        it { should have_field "Description" }
        it { should have_field "Media link" }
        it { should have_field "Progress" }

        describe "The add process" do
          before do
            fill_in "Header", with: "test Header 1"
            fill_in "Description", with: "test Description 1"
            fill_in "Media link", with: "test Media link 1"
            fill_in "Progress", with: 35
            click_button "Save"
          end
          
          it { should have_content "saved successfully" }
        end
      end
    end
  end
end
