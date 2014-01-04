class ShowreelController < ApplicationController
  before_filter :authorize, :except => :show

  def show
    @content = Showreel.find params[:id]
  end

  def edit
    @content = Showreel.find params[:id]
  end
end
