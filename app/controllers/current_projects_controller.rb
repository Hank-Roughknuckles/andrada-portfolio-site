class CurrentProjectsController < ApplicationController
  def index
    @projects = CurrentProject.all
  end
end
