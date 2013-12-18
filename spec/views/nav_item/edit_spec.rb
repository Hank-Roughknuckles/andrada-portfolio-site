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

    it { should have_xpath "//input[@id=\"nav_item_link_1_name\"]" }
    it { should have_xpath "//input[@id=\"nav_item_link_2_name\"]" }
    it { should have_xpath "//input[@id=\"nav_item_link_3_name\"]" }
    it { should have_xpath "//input[@id=\"nav_item_link_4_name\"]" }
    it { should have_xpath "//input[@id=\"nav_item_link_5_name\"]" }

    describe "The navbar editing process" do
      before do
        fill_in "nav_item_link_1_name", with: "Test_Link_1"
        fill_in "nav_item_link_2_name", with: "Test_Link_2"
        fill_in "nav_item_link_3_name", with: "Test_Link_3"
        fill_in "nav_item_link_4_name", with: "Test_Link_4"
        fill_in "nav_item_link_5_name", with: "Test_Link_5"
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
