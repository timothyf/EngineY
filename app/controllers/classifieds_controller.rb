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

class ClassifiedsController < ApplicationController

  before_filter :login_required, :only => [:new, :edit, :create, :update]
 
  def index
    @section = 'CLASSIFIEDS' 
    @classifieds = Classified.find(:all, :order => 'created_at DESC')
    respond_to do |format|
      format.html { render :template=>'classifieds/classifieds_list' } 
      format.xml  { render :xml => @classifieds }
      format.json { render :json => @classifieds }
    end
  end


  def show
    @classified = Classified.find(params[:id])
    respond_to do |format|
      format.html { render :template=>'classifieds/classifieds_show' } 
      format.xml  { render :xml => @classified }
      format.json  { render :json => @classified }
    end
  end


  def new
    @classified = Classified.new
  end


  def edit
    @classified = Classified.find(params[:id])
  end


  def create
    @classified = Classified.new(params[:classified])
    @classified.user = current_user;
    respond_to do |format|
      if @classified.save
        flash[:notice] = 'Classified was successfully created.'
        format.html { redirect_to(classifieds_path) }
        format.xml  { render :xml => @classified, :status => :created, :location => @classified }
        format.json  { render :json => @classified, :status => :created, :location => @classified }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @classified.errors, :status => :unprocessable_entity }
        format.json  { render :json => @classified.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @classified = Classified.find(params[:id])
    respond_to do |format|
      if @classified.update_attributes(params[:classified])
        flash[:notice] = 'Classified was successfully updated.'
        format.html { redirect_to(@classified) }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @classified.errors, :status => :unprocessable_entity }
        format.json { render :json => @classified.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @classified = Classified.find(params[:id])
    @classified.destroy
    respond_to do |format|
      format.html { redirect_to(classifieds_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
end
