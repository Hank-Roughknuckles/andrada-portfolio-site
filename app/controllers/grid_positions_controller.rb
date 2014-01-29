class GridPositionsController < ApplicationController
  def update
    @position = GridPosition.find(params[:id])
    if @position.update_attributes grid_positions_params
      render "_grid_save_success"
    else
      render "_grid_save_failure"
    end

  end

  def grid_positions_params
    params.permit(:parent_name, :serialized_array)
  end
end
