class AboutMeContentsController < ApplicationController
  def show
    @contents = AboutMeContent.all
  end

  def edit
  end

  def update
    id = AboutMeContent.find_by(header: params[:about_me_content][:header])
    redirect_to("/about_me_content/edit/" + @about_me_content.id)
  end
end
