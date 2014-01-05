class ShowreelController < ApplicationController
  before_filter :authorize, :except => :show
  helper_method :get_video_id

  def show
    @content = Showreel.find params[:id]
  end

  def edit
    @content = Showreel.find params[:id]
  end

  def update
    #if link isn't vimeo, throw an error

    @content = Showreel.find(params[:id])
    if @content.update_attributes showreel_params
      # @content = Showreel.all
      redirect_to action: "show"
    else
      flash[:alert] = "Invalid video link.  Please use a link to a video on Vimeo"
      render 'edit'
    end

  end

  def showreel_params
    params.require(:showreel).permit(:header, :description, :video_link)
  end

  # given a link to a vimeo video, return the id number for the video to
  # be used in the embed code in the view
  def get_video_id( link )
    /^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$/.match(link)[6]
  end
end
