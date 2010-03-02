class FacebookPostsController < ApplicationController

  def index
    @facebook_posts = FacebookPost.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @facebook_posts }
    end
  end


  def show
    @facebook_post = FacebookPost.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @facebook_post }
    end
  end


  def new
    @facebook_post = FacebookPost.new
  end


  def edit
    @facebook_post = FacebookPost.find(params[:id])
  end


  def create
    @facebook_post = FacebookPost.new(params[:facebook_post])
    respond_to do |format|
      if @facebook_post.save
        flash[:notice] = 'FacebookPost was successfully created.'
        format.html { redirect_to(@facebook_post) }
        format.xml  { render :xml => @facebook_post, :status => :created, :location => @facebook_post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @facebook_post.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @facebook_post = FacebookPost.find(params[:id])
    respond_to do |format|
      if @facebook_post.update_attributes(params[:facebook_post])
        flash[:notice] = 'FacebookPost was successfully updated.'
        format.html { redirect_to(@facebook_post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @facebook_post.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @facebook_post = FacebookPost.find(params[:id])
    @facebook_post.destroy
    respond_to do |format|
      format.html { redirect_to(facebook_posts_url) }
      format.xml  { head :ok }
    end
  end
end
