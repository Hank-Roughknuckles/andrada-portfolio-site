require 'spec_helper'

describe "AboutMePages" do

  subject{ page }

  describe "'About Me' index Page" do
    before { visit root_path }
    it { should have_title 'Andrada Popan-Dorca' }
  end
end
