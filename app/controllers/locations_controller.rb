class LocationsController < ApplicationController
  def index
    @locations = Location.find(:all, :conditions => "active = true", :order => "name desc")
    respond_to do |format|
      format.html { render :template => 'locations/index' }
      format.xml  { render :xml => @locations }
      format.json { render :json => @locations.to_json }
    end
  end

  def show
    @location = Location.find(params[:id])
    respond_to do |format|
      format.html # location.html.erb
      format.xml  { render :xml => @location }
      format.json { render :json => @location.to_json }
    end
  end

  def new
    @location = Location.new
  end

  def edit
    @location = Location.find(params[:id])
  end

  def create
    @location = Location.new(params[:location])
      if @location.save
        format.html {
          if params['admin_page']
            redirect_to('/admin/locations')
          else
            redirect_to(@location)
          end
        }
        format.xml  { render :xml => @location, :status => :created, :location => @location }
        format.json { render :json => @location.to_json, :status => :created, :location => @location }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
        format.json { render :json => @location.errors.to_json, :status => :unprocessable_entity }
      end

  end

  def update
    @location = Location.find(params[:id])
    respond_to do |format|
      if @location.update_attributes(params[:location])
        flash[:notice] = 'Location was successfully updated.'
        format.html {
          if params['admin_page']
            redirect_to('/admin/locations')
          else
            redirect_to(@location)
          end
        }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
        format.json { render :json => @location.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end

end
