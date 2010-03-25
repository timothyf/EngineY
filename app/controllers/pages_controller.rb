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

class PagesController < ApplicationController

  def show
    @page = Page.find_by_title(params[:title])
    @page_name = @page.title
    if current_user
      @user = current_user
    end
  end
  
  
  def create
    @page = Page.new(params[:page])
    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/pages')
          else
            redirect_to(@page) 
          end  
        }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @page = Page.find(params[:id])
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/pages')
          else
            redirect_to(@page) 
          end  
         }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    respond_to do |format|
      format.html { redirect_to(pages_url) }
      format.xml  { head :ok }
    end
  end
  
  
end
