class WidgetLayoutsController < ApplicationController
  # GET /widget_layouts
  # GET /widget_layouts.xml
  def index
    @widget_layouts = WidgetLayout.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @widget_layouts }
    end
  end

  # GET /widget_layouts/1
  # GET /widget_layouts/1.xml
  def show
    @widget_layout = WidgetLayout.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @widget_layout }
    end
  end

  # GET /widget_layouts/new
  # GET /widget_layouts/new.xml
  def new
    @widget_layout = WidgetLayout.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @widget_layout }
    end
  end

  # GET /widget_layouts/1/edit
  def edit
    @widget_layout = WidgetLayout.find(params[:id])
  end

  # POST /widget_layouts
  # POST /widget_layouts.xml
  def create
    @widget_layout = WidgetLayout.new(params[:widget_layout])

    respond_to do |format|
      if @widget_layout.save
        flash[:notice] = 'WidgetLayout was successfully created.'
        format.html { redirect_to(@widget_layout) }
        format.xml  { render :xml => @widget_layout, :status => :created, :location => @widget_layout }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @widget_layout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /widget_layouts/1
  # PUT /widget_layouts/1.xml
  def update
    @widget_layout = WidgetLayout.find(params[:id])

    respond_to do |format|
      if @widget_layout.update_attributes(params[:widget_layout])
        flash[:notice] = 'WidgetLayout was successfully updated.'
        format.html { redirect_to(@widget_layout) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @widget_layout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /widget_layouts/1
  # DELETE /widget_layouts/1.xml
  def destroy
    @widget_layout = WidgetLayout.find(params[:id])
    @widget_layout.destroy

    respond_to do |format|
      format.html { redirect_to(widget_layouts_url) }
      format.xml  { head :ok }
    end
  end
end
