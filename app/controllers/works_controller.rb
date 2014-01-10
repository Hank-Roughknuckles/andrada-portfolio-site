class WorksController < ApplicationController
  before_filter :authorize, :except => :index

  def index
    @contents = Works.all
  end

  def edit
    @content = Works.find params[:id]
  end

  def update
    @content = Works.find(params[:id])
    if @content.update_attributes works_params
      redirect_to action: "index"
    else
      flash[:alert] = "Invalid video link.  Please use a link to a video on Vimeo"
      render 'edit'
    end
  end

  def works_params
    params.require(:works).permit(:header, :description, :video_link)
  end
end
