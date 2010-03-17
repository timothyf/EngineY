class FollowsController < ApplicationController

  before_filter :login_required, :except => [:index, :show]


  def index
    user = User.find(params[:user_id])
    if params[:type] == 'followers'
      @follows = user.followers
      respond_to do |format|
        format.html {  } 
        format.xml  { render :xml => @follows }
        format.json { render :json => @follows }
      end
    elsif params[:type] == 'followees'
      @follows = user.followees
      respond_to do |format|
        format.html {  } 
        format.xml  { render :xml => @follows }
        format.json { render :json => @follows }
      end
    end
  end


  def show
    @follow = Follow.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @follow }
      format.json { render :json => @follow }
    end
  end


  def create
    @follow = Follow.new(params[:follow])
    followee_id = params[:followee_id] 
    @follow = Follow.new(:follower_id => current_user.id,
                         :followee_id => followee_id)
    respond_to do |format|
      if @follow.save
        flash[:notice] = 'Follow was successfully created.'
        format.html { redirect_to(@follow) }
        format.xml  { render :xml => @follow, :status => :created, :location => @follow }
        format.json { render :json => @follow, :status => :created, :location => @follow }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @follow.errors, :status => :unprocessable_entity }
        format.json { render :json => @follow.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @follow = Follow.find(params[:id])
    respond_to do |format|
      if @follow.update_attributes(params[:follow])
        flash[:notice] = 'Follow was successfully updated.'
        format.html { redirect_to(@follow) }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @follow.errors, :status => :unprocessable_entity }
        format.json { render :json => @follow.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @follow = Follow.find(params[:id])
    @follow.destroy
    respond_to do |format|
      format.html { redirect_to(follows_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
  
  
end
