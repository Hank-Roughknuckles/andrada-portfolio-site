class ContactController < ApplicationController
  before_filter :authorize, :except => :show
  helper_method :get_slide_background_css

  def show
    @contact_info = Contact.find params[:id] 
  end

  def edit
    @contact_info = Contact.find params[:id]
  end

  def update
    @contact_info = Contact.find params[:id]
    if @contact_info.update_attributes contact_params
      flash[:notice] = "Contact information updated successfully"
      redirect_to action: "show"
    else
      flash[:alert] = "Invalid email address, please try again"
      render "edit"
    end
  end

  def contact_params
    params.require(:contact).permit(:email, :vimeo_id, :background_image)
  end
end
