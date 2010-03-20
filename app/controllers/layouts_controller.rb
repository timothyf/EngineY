class LayoutsController < ApplicationController
  # GET /layouts
  # GET /layouts.xml
  def index
    @layouts = Layout.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @layouts }
    end
  end

  # GET /layouts/1
  # GET /layouts/1.xml
  def show
    @layout = Layout.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @layout }
    end
  end

  # GET /layouts/new
  # GET /layouts/new.xml
  def new
    @layout = Layout.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @layout }
    end
  end

  # GET /layouts/1/edit
  def edit
    @layout = Layout.find(params[:id])
  end

  # POST /layouts
  # POST /layouts.xml
  def create
    @layout = Layout.new(params[:layout])

    respond_to do |format|
      if @layout.save
        flash[:notice] = 'Layout was successfully created.'
        format.html { redirect_to(@layout) }
        format.xml  { render :xml => @layout, :status => :created, :location => @layout }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @layout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /layouts/1
  # PUT /layouts/1.xml
  def update
    @layout = Layout.find(params[:id])

    respond_to do |format|
      if @layout.update_attributes(params[:layout])
        flash[:notice] = 'Layout was successfully updated.'
        format.html { redirect_to(@layout) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @layout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /layouts/1
  # DELETE /layouts/1.xml
  def destroy
    @layout = Layout.find(params[:id])
    @layout.destroy

    respond_to do |format|
      format.html { redirect_to(layouts_url) }
      format.xml  { head :ok }
    end
  end
end
