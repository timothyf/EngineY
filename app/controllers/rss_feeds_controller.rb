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

=begin
  This class serves as the entry point for management of RSS feed setup.
=end
class RssFeedsController < ApplicationController

  def index
    @rss_feeds = RssFeed.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rss_feeds }
    end
  end


  def new
    @rss_feed = RssFeed.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rss_feed }
    end
  end


  def edit
    @rss_feed = RssFeed.find(params[:id])
  end


  def create
    @rss_feed = RssFeed.new(params[:rss_feed])
    respond_to do |format|
      if @rss_feed.save
        flash[:notice] = 'RssFeed was successfully created.'
        format.html { redirect_to(@rss_feed) }
        format.xml  { render :xml => @rss_feed, :status => :created, :location => @rss_feed }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rss_feed.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @rss_feed = RssFeed.find(params[:id])
    respond_to do |format|
      if @rss_feed.update_attributes(params[:rss_feed])
        flash[:notice] = 'RssFeed was successfully updated.'
        format.html { redirect_to(@rss_feed) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rss_feed.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @rss_feed = RssFeed.find(params[:id])
    @rss_feed.destroy
    respond_to do |format|
      format.html { redirect_to(rss_feeds_url) }
      format.xml  { head :ok }
    end
  end
end
