require 'spec_helper'

describe "AboutMePages" do

  subject{ page }

  describe "'About Me' Page" do
    it { should have_content 'Sample App' }
    
  end
end
