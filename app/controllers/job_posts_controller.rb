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

class JobPostsController < ApplicationController
 
  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]
  
  # only job_post creator or an admin can edit or update the job post.
  before_filter :check_auth, :only => [:edit, :update]
  
  before_filter :set_section
  
  def check_auth
    
  end
  
  def set_section
    @section = 'JOBS' 
  end
  
  def index
    @job_posts = JobPost.find(:all, :order=>'created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @job_posts }
    end
  end


  def new
    @job_post = JobPost.new
  end


  def edit
    @job_post = JobPost.find(params[:id])
    render :template => 'job_posts/job_posts_edit'
  end


  def create
    @job_post = JobPost.new(params[:job_post])
    respond_to do |format|
      if @job_post.save
        flash[:notice] = 'JobPost was successfully created.'
        format.html { redirect_to(job_posts_url) }
        format.xml  { render :xml => @job_post, :status => :created, :location => @job_post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job_post.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @job_post = JobPost.find(params[:id])
    respond_to do |format|
      if @job_post.update_attributes(params[:job_post])
        flash[:notice] = 'JobPost was successfully updated.'
        format.html { redirect_to(job_posts_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job_post.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @job_post = JobPost.find(params[:id])
    @job_post.destroy
    respond_to do |format|
      format.html { redirect_to(job_posts_url) }
      format.xml  { head :ok }
    end
  end
end
