class AboutMeContentsController < ApplicationController
  before_filter :authorize, :except => :index
  helper_method :get_slide_background_css

  def index
    @count = AboutMeContent.count
    @contents = AboutMeContent.all
  end

  def admin_index
    @contents = AboutMeContent.all
  end

  def edit
    @content = AboutMeContent.find(params[:id])
    @count = AboutMeContent.count
  end

  def update
    @content = AboutMeContent.find(params[:id])
    if @content.update_attributes! content_params
      @contents = AboutMeContent.all
      redirect_to action: "index"
    else
      render 'edit'
    end
  end

  def content_params
    params.require(:about_me_content).permit(:background_image, :header, :description, :button_title)
  end

  def get_slide_background_css(slide_id)
    image = AboutMeContent.find(slide_id).background_image;

    if image != nil
      "background: url(#{AboutMeContent.find(slide_id).background_image})"
    else
      return
    end
  end

end
