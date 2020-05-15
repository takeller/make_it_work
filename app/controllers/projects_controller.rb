class ProjectsController < ApplicationController

  def show
    @project = Project.find(params[:id])
  end

  def update
    project = Project.find(params[:id])
    if params[:contestant_id] != nil
      project.add_contestant(params[:contestant_id])
    end 
  end
end
