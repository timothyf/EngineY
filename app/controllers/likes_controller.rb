class LikesController < ApplicationController
  
  include ActivityFeedHelper
  
  def create
    user_id = params[:user_id]
    likable_id = params[:likable_id]
    likable_type = params[:likable_type]
    
    # prevent a user from liking something twice
    like = Like.find_by_user_id_and_likable_id_and_likable_type(user_id, likable_id, likable_type)
    if like == nil || like.size == 0
      @like = Like.create(:user_id => user_id, :likable_id => likable_id, :likable_type => likable_type)
    end
    
    respond_to do |format|
      #if @like.save
        format.xml  { render :xml => @like, :status => :created, :location => @like }
        format.json {render :json => @like, :status => :created, :location => @like }
      #else
      #  format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      #  format.json  { render :json => @link.errors.to_json, :status => :unprocessable_entity }
      #end
    end
  end
  
  
  def like_text
    activity = Activity.find(params[:activity_id])
    render :text=>display_like_text(activity), :layout => false
  end
  
  
  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    respond_to do |format|
      format.html { redirect_to(likes_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
  
  
end
