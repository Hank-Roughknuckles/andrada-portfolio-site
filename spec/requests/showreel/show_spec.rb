require 'spec_helper'

describe "ShowreelPages" do
  subject { page }

  describe "show page contents" do
    before do
      visit root_path
      click_link "Showreel"
    end

    it { should have_title "Showreel" }
  end
  
end
