require 'spec_helper'

describe "LoginPage" do

  subject{ page }

  describe "'About Me' index Page" do
    before { visit new_sessions_path }

    it { should have_content "Login" }
    it { should have_title "Login" }
    # fill_in "email", :with => "asdf"
    # fill_in "password", :with => "asdf"
    # click_link "Login"
  end
end
