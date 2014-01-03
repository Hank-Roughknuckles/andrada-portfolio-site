class ShowreelController < ApplicationController
  def show
    @content = Showreel.find params[:id]
  end
end
