require 'spec_helper'

describe "WorksPages" do
  let!(:user) { FactoryGirl.create :user }
  let!(:works1) { FactoryGirl.create :works }
  let!(:works2) { FactoryGirl.create :works }

  subject { page }

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

        #TODO: the following should be xpaths to show that they're in
        #a table
        it { should have_content works1.header }
        it { should have_content works1.description }
        it { should have_content works1.video_link }
        it { should have_content works2.header }
        it { should have_content works2.description }
        it { should have_content works2.video_link }
        it { should have_link "Edit" }
      end
    end
  end
end
