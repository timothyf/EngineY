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


class BookReviewsController < ApplicationController

  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]
  
  
  def index
    @book_reviews = BookReview.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @book_reviews }
    end
  end


  def show
    @book_review = BookReview.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book_review }
    end
  end


  def new
    @book_review = BookReview.new
  end


  def edit
    @book_review = BookReview.find(params[:id])
  end


  def create
    @book_review = BookReview.new(params[:book_review])
    respond_to do |format|
      if @book_review.save
        flash[:notice] = 'BookReview was successfully created.'
        format.html { redirect_to(@book_review) }
        format.xml  { render :xml => @book_review, :status => :created, :location => @book_review }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @book_review.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @book_review = BookReview.find(params[:id])
    respond_to do |format|
      if @book_review.update_attributes(params[:book_review])
        flash[:notice] = 'BookReview was successfully updated.'
        format.html { redirect_to(@book_review) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book_review.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @book_review = BookReview.find(params[:id])
    @book_review.destroy
    respond_to do |format|
      format.html { redirect_to(book_reviews_url) }
      format.xml  { head :ok }
    end
  end
end
