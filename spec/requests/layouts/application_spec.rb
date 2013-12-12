require 'spec_helper'

describe "ApplicationLayout" do

  subject{ page }

  describe "Title on page" do
    before { visit root_path }
    it { should have_title 'Andrada' }
  end

end
