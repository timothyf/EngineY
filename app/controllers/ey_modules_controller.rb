class EyModulesController < ApplicationController
  # GET /ey_modules
  # GET /ey_modules.xml
  def index
    @ey_modules = EyModule.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ey_modules }
    end
  end

  # GET /ey_modules/1
  # GET /ey_modules/1.xml
  def show
    @ey_module = EyModule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ey_module }
    end
  end

  # GET /ey_modules/new
  # GET /ey_modules/new.xml
  def new
    @ey_module = EyModule.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ey_module }
    end
  end

  # GET /ey_modules/1/edit
  def edit
    @ey_module = EyModule.find(params[:id])
  end

  # POST /ey_modules
  # POST /ey_modules.xml
  def create
    @ey_module = EyModule.new(params[:ey_module])

    respond_to do |format|
      if @ey_module.save
        flash[:notice] = 'EyModule was successfully created.'
        format.html { redirect_to(@ey_module) }
        format.xml  { render :xml => @ey_module, :status => :created, :location => @ey_module }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ey_module.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ey_modules/1
  # PUT /ey_modules/1.xml
  def update
    @ey_module = EyModule.find(params[:id])

    respond_to do |format|
      if @ey_module.update_attributes(params[:ey_module])
        flash[:notice] = 'EyModule was successfully updated.'
        format.html { redirect_to(@ey_module) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ey_module.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ey_modules/1
  # DELETE /ey_modules/1.xml
  def destroy
    @ey_module = EyModule.find(params[:id])
    @ey_module.destroy

    respond_to do |format|
      format.html { redirect_to(ey_modules_url) }
      format.xml  { head :ok }
    end
  end
end
