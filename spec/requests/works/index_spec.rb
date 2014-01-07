require 'spec_helper'

describe "WorksPages" do
  let(:user) { FactoryGirl.create :user }

  subject { page }

  describe "The page layout" do
    describe "when not signed in" do
      before do
        logout :user
        visit works_path
      end

      it { should_not have_content "Edit Content" }
      it { should have_content "Sign In" }
    end

    describe "when signed in" do
      before do
        login_as user
        visit works_path
      end

      it { should have_content "Edit Content" }
      it { should have_content "Sign Out" }
    end

  end
end
