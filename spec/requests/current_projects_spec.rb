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
        print page.html
      end
      it { should have_xpath "//table//td/a[text()=\"Edit\"]" }
      it { should have_content "Add Project" }
    end
  end
end
