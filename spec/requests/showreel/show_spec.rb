require 'spec_helper'

describe "ShowreelPages" do
  let(:showreel) { FactoryGirl.create :showreel }
  subject { page }

  describe "show page contents" do
    before do
      visit showreel_path showreel.id
    end

    it { should have_title "Showreel" }
  end
  
end
