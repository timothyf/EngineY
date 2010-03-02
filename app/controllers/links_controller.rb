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

class LinksController < ApplicationController
  
  
  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]
  
  
  def index
    @section = 'LINKS' 
    if params[:user_id]
      @user = User.find(params[:user_id])
      @links = @user.links.paginate(:all, :page => params[:page], :order => 'created_at DESC')
      @link_count = @user.links.length
    else
      @links = Link.paginate(:all, :page => params[:page], :order => 'created_at DESC') 
      @link_count = Link.count
    end   
    respond_to do |format|
      format.html { render :partial=>'links_canvas', :layout=>true } # index.html.erb
      format.xml  { render :xml => @links }
      format.json { render :json => @links.to_json } 
    end
  end
  
  
  def show
    @link = Link.find(params[:id])
    respond_to do |format|
      format.xml  { render :xml => @link }
      format.json { render :json => @link.to_json } 
    end
  end


  def new
    @section = 'LINKS' 
    @link = Link.new
  end


  def edit
    @link = Link.find(params[:id])
  end


  def create
    @link = Link.new(params[:link])
    @link.user_id = current_user.id
    respond_to do |format|
      if @link.save
        flash[:notice] = 'Link was successfully created.'
        format.html { redirect_to(links_path) }
        format.xml  { render :xml => @link, :status => :created, :location => @link }
        format.json {render :json => @link.to_json, :status => :created, :location => @link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
        format.json  { render :json => @link.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @link = Link.find(params[:id])
    respond_to do |format|
      if @link.update_attributes(params[:link])
        flash[:notice] = 'Link was successfully updated.'
        format.html { redirect_to(links_path) }
        format.xml  { head :ok }
        format.json { head :ok } 
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
        format.json  { render :json => @link.errors.to_json, :status => :unprocessable_entity } 
      end
    end
  end


  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    respond_to do |format|
      format.html { redirect_to(links_url) }
      format.xml  { head :ok }
      format.json { head :ok } 
    end
  end
end
