class AboutMeContentsController < ApplicationController
  before_filter :authorize, :except => :index
  helper_method :all_contents

  def index
    @count = AboutMeContent.count
    @contents = AboutMeContent.all
  end

  def edit
    @content = AboutMeContent.find(params[:id])
  end

  def content_params
    params.require(:about_me_content).permit(:background_image, :header, :description, :button_title)
  end

  def all_contents
    AboutMeContent.all
  end

  def update
    @content = AboutMeContent.find(params[:id])
    if @content.update_attributes content_params
      @contents = AboutMeContent.all
      redirect_to action: "index"
    else
      render 'edit'
    end
  end
end
