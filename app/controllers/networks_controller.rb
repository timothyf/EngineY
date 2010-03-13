class NetworksController < ApplicationController
  
  def edit
    @network = Network.find(params[:id])
  end
  
  
  def update
    @network = Network.find(params[:id])
    respond_to do |format|
      if @network.update_attributes(params[:network])       
        format.html { 
          flash[:notice] = 'Network was successfully updated.'
          redirect_to(@network) 
         }
        format.xml  { head :ok }
        format.json { head :ok } 
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @network.errors, :status => :unprocessable_entity }
        format.xml  { render :json => @network.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
