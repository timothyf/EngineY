#   Copyright 2009 Timothy Fisher
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

class MessagesController < ApplicationController

  uses_tiny_mce :options => {
                              :theme => 'advanced',
                              :theme_advanced_toolbar_location => "top",
                              :theme_advanced_toolbar_align => "left",
                              :theme_advanced_resizing => true,
                              :theme_advanced_resize_horizontal => false,
                              :theme_advanced_buttons1 => "forecolor,backcolor,bullist,numlist,separator,outdent,indent,separator,undo,redo,separator,link,unlink,anchor,image,cleanup,help,code",
                              :theme_advanced_buttons2 => "",
                              :theme_advanced_buttons3 => ""
                            }
                            
  before_filter :login_required
  
                            
  def index
    user = User.find(params[:user_id])
    @sent_messages = user.sent_messages
    @received_messages = user.received_messages
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end


  def show
    @message = Message.find(params[:id])
    if current_user == @message.recipient
      @message.update_attributes(:read=>true)
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end


  def new
    @message = Message.new
    @recipient_id = params[:recipient_id]
    @subject = params[:subject]
    if @recipient_id == nil
      @users = User.find(:all, :conditions => "activated_at is not null")
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end


  def create
    @message = Message.new(params[:message])
    @message.sender_id = current_user.id
    respond_to do |format|
      if @message.save
        flash[:notice] = 'Message was successfully created.'
        # TODO send email notification to recipient
        
        format.html { redirect_to(@message) }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @message = Message.find(params[:id])
    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Message was successfully updated.'
        format.html { redirect_to(@message) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    respond_to do |format|
      format.html { redirect_to(user_messages_url(current_user)) }
      format.xml  { head :ok }
    end
  end
end
