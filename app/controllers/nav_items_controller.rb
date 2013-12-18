class NavItemsController < ApplicationController
  def edit
    @navItem = NavItem.find 0
  end

  def update
    @navItem = NavItem.find(params[:id])
    if @navItem.update_attributes( nav_item_params )
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def nav_item_params
    params.require(:nav_item).permit(:link_1_name, :link_2_name,
                                     :link_3_name, :link_4_name,
                                     :link_5_name)
  end
end
