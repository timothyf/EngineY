#   Copyright 2009 Timothy Fisher
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

class ProjectsController < ApplicationController

  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]

  def index
    @projects = Project.find(:all)
    respond_to do |format|
      format.html { render :partial => 'projects_canvas', :layout=>true }
      format.xml  { render :xml => @projects }
      format.json { render :json => @projects.to_json } 
    end
  end


  def show
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html { render :template => 'projects/projects_show' }
      format.xml  { render :xml => @project }
      format.json { render :json => @project.to_json } 
    end
  end


  def new
    @project = Project.new
  end


  def edit
    @project = Project.find(params[:id])
  end


  def create
    @project = Project.new(params[:project])
    @project.user_id = current_user.id
    respond_to do |format|
      if @project.save
        flash[:notice] = 'Projects was successfully created.'
        format.html { redirect_to(projects_path) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
        format.json { render :json => @project.to_json, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
        format.json  { render :json => @project.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(projects_path) }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
        format.json  { render :json => @project.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to(projects_path) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
  
  
end
