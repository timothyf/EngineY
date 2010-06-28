class NavItemsController < ApplicationController
  # GET /nav_items
  # GET /nav_items.xml
  def index
    @nav_items = NavItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nav_items }
    end
  end

  # GET /nav_items/1
  # GET /nav_items/1.xml
  def show
    @nav_item = NavItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nav_item }
    end
  end

  # GET /nav_items/new
  # GET /nav_items/new.xml
  def new
    @nav_item = NavItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nav_item }
    end
  end

  # GET /nav_items/1/edit
  def edit
    @nav_item = NavItem.find(params[:id])
  end

  # POST /nav_items
  # POST /nav_items.xml
  def create
    @nav_item = NavItem.new(params[:nav_item])

    respond_to do |format|
      if @nav_item.save
        flash[:notice] = 'NavItem was successfully created.'
        format.html { redirect_to(@nav_item) }
        format.xml  { render :xml => @nav_item, :status => :created, :location => @nav_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @nav_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nav_items/1
  # PUT /nav_items/1.xml
  def update
    @nav_item = NavItem.find(params[:id])

    respond_to do |format|
      if @nav_item.update_attributes(params[:nav_item])
        flash[:notice] = 'NavItem was successfully updated.'
        format.html { redirect_to(@nav_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @nav_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nav_items/1
  # DELETE /nav_items/1.xml
  def destroy
    @nav_item = NavItem.find(params[:id])
    @nav_item.destroy

    respond_to do |format|
      format.html { redirect_to(nav_items_url) }
      format.xml  { head :ok }
    end
  end
end
