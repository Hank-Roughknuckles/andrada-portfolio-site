class ShowreelController < ApplicationController
  before_filter :authorize, :except => :show
  helper_method :embed_video

  def show
    @content = Showreel.find params[:id]
  end

  def edit
    @content = Showreel.find params[:id]
  end

  def update
    @content = Showreel.find(params[:id])
    if @content.update_attributes showreel_params
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
  def embed_video( link )
    vimeo_id = /^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$/.match(link)[6]
    return "<iframe src=\"//player.vimeo.com/video/#{vimeo_id}\" width=\"500\"
    height=\"375\" frameborder=\"0\" webkitallowfullscreen
    mozallowfullscreen allowfullscreen></iframe>".html_safe
  end
end
