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
class IdeasController < ApplicationController

  def index
    @ideas = Idea.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ideas }
    end
  end


  def show
    @idea = Idea.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @idea }
    end
  end


  def new
    @idea = Idea.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @idea }
    end
  end


  def edit
    @idea = Idea.find(params[:id])
  end


  def create
    @idea = Idea.new(params[:idea])
    @idea.user = current_user
    respond_to do |format|
      if @idea.save
        flash[:notice] = 'Idea was successfully created.'
        format.html { redirect_to(@idea) }
        format.xml  { render :xml => @idea, :status => :created, :location => @idea }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @idea = Idea.find(params[:id])
    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        flash[:notice] = 'Idea was successfully updated.'
        format.html { redirect_to(@idea) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to(ideas_url) }
      format.xml  { head :ok }
    end
  end
end
