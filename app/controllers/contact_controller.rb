class ContactController < ApplicationController
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
    params.require(:contact).permit(:email, :vimeo_id)
  end
end
