class WorksController < ApplicationController
  before_filter :authorize, :except => :index

  def index
    @contents = Work.all
  end

  def edit
    @contents = Work.all
    @content = Work.find params[:id]
  end

  def new
    @content = Work.new( media_link: "https://vimeo.com/14470340", media_choice: "link" )
  end

  def create
    @content = Work.new(works_params)

    if @content.save
      flash[:notice] = "New Work Added"
      redirect_to action: "index"
    else
      flash[:alert] = "Invalid video link.  Please use a link to a video
      on Vimeo or Youtube"
      render 'new'
    end

  end

  def update
    @content = Work.find(params[:id])
    if @content.update_attributes works_params
      redirect_to action: "index"
    else
      flash[:alert] = "Invalid video link.  Please use a link to a video
      on Vimeo or Youtube"
      render 'edit'
    end
  end

  def destroy
    if @content = Work.find(params[:id])
      @content.destroy
      redirect_to action: "index"
      flash[:notice] = "Work Was Deleted Successfully"
    else
      flash[:error] = "An error occurred, please contact the
      web-programmer"
    end
  end

  def works_params
    params.require(:work).permit(:header, :description, :media_link, :media_choice, :media_image, :background_image, :grid_tile_image)
  end
end
