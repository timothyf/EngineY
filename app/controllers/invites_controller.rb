class InvitesController < ApplicationController

  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]
  
  
  def index
    @invites = Invite.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invites }
      format.json  { render :json => @invites.to_json }
    end
  end


  def show
    @invite = Invite.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invite }
      format.json  { render :json => @invite.to_json }
    end
  end


  def new
    @invite = Invite.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invite }
      format.json  { render :json => @invite.to_json }
    end
  end


  def edit
    @invite = Invite.find(params[:id])
  end


  def create
    @invite = Invite.new(params[:invite])
    @invite.user = current_user
    @invite.accepted = false
    @invite.invite_code = Invite.generate_invite_code
    
    # see if recipient has already been invited by this user
    
    
    respond_to do |format|
      if @invite.save
        flash[:notice] = 'Invite was successfully created.'
        format.html { redirect_to(@invite) }
        format.xml  { render :xml => @invite, :status => :created, :location => @invite }
        format.json  { render :json => @invite.to_json, :status => :created, :location => @invite }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invite.errors, :status => :unprocessable_entity }
        format.json  { render :json => @invite.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @invite = Invite.find(params[:id])
    respond_to do |format|
      if @invite.update_attributes(params[:invite])
        flash[:notice] = 'Invite was successfully updated.'
        format.html { redirect_to(@invite) }
        format.xml  { head :ok }
        format.json { head :ok } 
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invite.errors, :status => :unprocessable_entity }
        format.json { render :json => @invite.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy
    respond_to do |format|
      format.html { redirect_to(invites_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end
  
end
