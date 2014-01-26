class CurrentProjectsController < ApplicationController
  def index
    @contents = CurrentProject.all
  end

  def new
    @content = CurrentProject.new( media_link: "https://vimeo.com/14470340", progress: 50, media_choice: "link" )
  end

  def create
    @content = CurrentProject.new( current_project_params )

    if @content.update_attributes current_project_params
      redirect_to action: "index"
      flash[:notice] = "Project saved successfully"
    else
      flash[:alert] = "Invalid video link.  Please use a link to a video
      on Vimeo or Youtube"
      render 'edit'
    end
  end

  def edit
    @content = CurrentProject.find params[:id]
  end

  def update
    @content = CurrentProject.find(params[:id])
    if @content.update_attributes current_project_params
      flash[:notice] = "Project updated successfully"
      redirect_to action: "index"
    else
      flash[:alert] = "Invalid video link.  Please use a link to a video
      on Vimeo or Youtube"
      render 'edit'
    end
  end

  def destroy
    if (@content = CurrentProject.find params[:id])
      @content.destroy
      redirect_to action: "index"
      flash[:notice] = "Project successfully deleted"
    else
      flash[:error] = "An error occurred, please contact the
      web-programmer"
    end
  end

  def current_project_params
    params.require(:current_project).permit(:header, :description, :media_link, :progress, :media_choice, :media_image)
  end
end
