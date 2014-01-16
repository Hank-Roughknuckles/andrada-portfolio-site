class ContactController < ApplicationController
  def show
    @contact_info = Contact.find params[:id] 
  end
end
