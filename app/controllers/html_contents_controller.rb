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

class HtmlContentsController < ApplicationController

  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]


  def index
    @html_contents = HtmlContent.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @html_contents }
    end
  end


  def new
    @html_content = HtmlContent.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @html_content }
    end
  end


  def edit
    @html_content = HtmlContent.find(params[:id])
  end


  def create
    @html_content = HtmlContent.new(params[:html_content])
    respond_to do |format|
      if @html_content.save
        flash[:notice] = 'HtmlContent was successfully created.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/pages')
          else
            redirect_to(@html_content) 
          end  
        }
        format.xml  { render :xml => @html_content, :status => :created, :location => @html_content }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @html_content.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @html_content = HtmlContent.find(params[:id])
    respond_to do |format|
      if @html_content.update_attributes(params[:html_content])
        flash[:notice] = 'HtmlContent was successfully updated.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/pages')
          else
            redirect_to('/') 
          end  
         }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @html_content.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @html_content = HtmlContent.find(params[:id])
    @html_content.destroy
    respond_to do |format|
      format.html { redirect_to(html_contents_url) }
      format.xml  { head :ok }
    end
  end
end
