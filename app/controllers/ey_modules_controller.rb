class EyModulesController < ApplicationController

  def index
    @ey_modules = EyModule.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ey_modules }
    end
  end


  def show
    @ey_module = EyModule.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ey_module }
    end
  end


  def new
    @ey_module = EyModule.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ey_module }
    end
  end


  def edit
    @ey_module = EyModule.find(params[:id])
  end


  def create
    @ey_module = EyModule.new(params[:ey_module])
    respond_to do |format|
      if @ey_module.save
        flash[:notice] = 'EyModule was successfully created.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/modules')
          else
            redirect_to(@ey_module) 
          end
        }
        format.xml  { render :xml => @ey_module, :status => :created, :location => @ey_module }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ey_module.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @ey_module = EyModule.find(params[:id])
    respond_to do |format|
      if @ey_module.update_attributes(params[:ey_module])
        flash[:notice] = 'EyModule was successfully updated.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/modules')
          else
            redirect_to(@ey_module) 
          end
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ey_module.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @ey_module = EyModule.find(params[:id])
    @ey_module.destroy
    respond_to do |format|
      format.html { redirect_to(ey_modules_url) }
      format.xml  { head :ok }
    end
  end
  
  
end
