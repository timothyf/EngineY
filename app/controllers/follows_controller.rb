class FollowsController < ApplicationController

  def index
    @follows = Follow.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @follows }
      format.json { render :json => @follows }
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


  def new
    @follow = Follow.new
  end


  def edit
    @follow = Follow.find(params[:id])
  end


  def create
    @follow = Follow.new(params[:follow])
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
