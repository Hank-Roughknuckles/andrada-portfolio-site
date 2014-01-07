class WorksController < ApplicationController
  before_filter :authorize, :except => :index

  def index
    @contents = Works.all
  end
end
