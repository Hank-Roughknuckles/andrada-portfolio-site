require 'spec_helper'

describe "Edit navbar" do
  subject{ page }

  let(:user) { FactoryGirl.create :user }
  let(:nav_item) { FactoryGirl.build :nav_item }

  describe "The edit page" do
    before do
      login_as user
      visit edit_nav_item_path nav_item.id
    end

    it { should have_xpath "//input[@id=\"nav_1_edit\"]" }
    it { should have_xpath "//input[@id=\"nav_2_edit\"]" }
    it { should have_xpath "//input[@id=\"nav_3_edit\"]" }
    it { should have_xpath "//input[@id=\"nav_4_edit\"]" }
    it { should have_xpath "//input[@id=\"nav_5_edit\"]" }

    describe "The navbar editing process" do
      before do
        fill_in "nav_1_edit", with: "Test_Link_1"
        fill_in "nav_2_edit", with: "Test_Link_2"
        fill_in "nav_3_edit", with: "Test_Link_3"
        fill_in "nav_4_edit", with: "Test_Link_4"
        fill_in "nav_5_edit", with: "Test_Link_5"
        click_button "Save"
      end
        
      it { should have_content "Test_Link_1" }
      it { should have_content "Test_Link_2" }
      it { should have_content "Test_Link_3" }
      it { should have_content "Test_Link_4" }
      it { should have_content "Test_Link_5" }
    end
  end
end
