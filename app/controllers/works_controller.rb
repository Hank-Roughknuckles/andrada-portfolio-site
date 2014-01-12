class WorksController < ApplicationController
  before_filter :authorize, :except => :index

  def index
    @contents = Work.all
  end

  def edit
    @content = Work.find params[:id]
  end

  def new
    @work = Work.new( video_link: "https://vimeo.com/14470340" )
  end

  def create
    @work = Work.new(works_params)

    if @work.save
      flash[:notice] = "New Work Added"
      redirect_to action: "index"
    else
      flash[:alert] = "Invalid video link.  Please use a link to a video
      on Vimeo"
      render 'new'
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
    params.require(:work).permit(:header, :description, :video_link)
  end
end
