class AboutMeContentsController < ApplicationController
  def index
    @contents = AboutMeContent.all
  end

  def edit
    @content = AboutMeContent.find(params[:id])
  end

  def content_params
    # TODO: add background image to this list
    params.require(:about_me_content).permit(:header, :description, :button_title)
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
