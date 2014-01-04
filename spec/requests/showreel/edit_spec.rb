require 'spec_helper'

describe "ShowreelEditPage" do
  let(:showreel) { FactoryGirl.create :showreel }
  let(:user) { FactoryGirl.create :user }
  subject { page }

  before do
    login_as user
    visit showreel_path showreel.id
  end

  describe "The link to the edit page" do
    it { should have_link "Edit Content" }
  end

  describe "The edit page" do
    before do
      visit showreel_path showreel.id
      click_link "Edit Content"
    end

    describe "Edit page contents" do
      it { should have_content "Header" }
      it { should have_content "Description" }
      it { should have_content "Video link" }
    end
  end
end
