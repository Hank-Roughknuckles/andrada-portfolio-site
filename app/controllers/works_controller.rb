class WorksController < ApplicationController
  before_filter :authorize, :except => :index

  def index
    @contents = Work.all
  end

  def edit
    @content = Work.find params[:id]
  end

  end

  def update
    @content = Work.find(params[:id])
    if @content.update_attributes works_params
      redirect_to action: "index"
    else
      flash[:alert] = "Invalid video link.  Please use a link to a video
      on Vimeo"
      render 'edit'
    end
  end

  def works_params
    params.require(:work).permit(:header, :description, :video_link)
  end
end
