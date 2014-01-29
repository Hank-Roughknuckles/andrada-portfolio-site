class CurrentProjectsController < ApplicationController
  before_filter :authorize, :except => :index

  def index
    @contents = CurrentProject.all
  end

  def new
    @contents = CurrentProject.all
    @content = CurrentProject.new( media_link: "https://vimeo.com/14470340", progress: 50, media_choice: "link" )
    @position = GridPosition.find_by(parent_name: "current_projects")
  end

  def create
    @contents = CurrentProject.all
    @content = CurrentProject.new( current_project_params )

    if @content.update_attributes current_project_params
      save_grid_position( caller: "current_projects" )
      flash[:notice] = "Project saved successfully"
      redirect_to action: "index"
    else
      flash[:alert] = "Invalid video link.  Please use a link to a video
      on Vimeo or Youtube"
      render 'edit'
    end
  end

  def edit
    @contents = CurrentProject.all
    @content = CurrentProject.find params[:id]
    @position = GridPosition.find_by(parent_name: "current_projects")
  end

  def update
    @contents = CurrentProject.all
    @content = CurrentProject.find(params[:id])
    if @content.update_attributes current_project_params
      save_grid_position( caller: "current_projects" )
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
    params.require(:current_project).permit(:header, :description,
                                            :media_link, :progress,
                                            :media_choice, :media_image,
                                            :grid_row, :grid_column,
                                            :grid_sizex, :grid_sizey,
                                            :grid_tile_image)
  end
end
