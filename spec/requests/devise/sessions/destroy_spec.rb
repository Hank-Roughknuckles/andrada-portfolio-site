require 'spec_helper.rb'

describe "The sign-out process" do
  subject { page }
  let(:user) { FactoryGirl.create :user }

  before do
    login_as user
    visit root_path
    click_link "Sign Out"
  end
  it { should have_content "Signed out" }
end

