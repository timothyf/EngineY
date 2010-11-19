class EventReviewsController < ApplicationController
  # GET /event_reviews
  # GET /event_reviews.xml
  def index
    @event_reviews = EventReview.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @event_reviews }
    end
  end

  # GET /event_reviews/1
  # GET /event_reviews/1.xml
  def show
    @event_review = EventReview.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event_review }
    end
  end

  # GET /event_reviews/new
  # GET /event_reviews/new.xml
  def new
    @event_review = EventReview.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event_review }
    end
  end

  # GET /event_reviews/1/edit
  def edit
    @event_review = EventReview.find(params[:id])
  end

  # POST /event_reviews
  # POST /event_reviews.xml
  def create
    @event_review = EventReview.new(params[:event_review])

    respond_to do |format|
      if @event_review.save
        flash[:notice] = 'EventReview was successfully created.'
        format.html { redirect_to(@event_review) }
        format.xml  { render :xml => @event_review, :status => :created, :location => @event_review }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event_review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /event_reviews/1
  # PUT /event_reviews/1.xml
  def update
    @event_review = EventReview.find(params[:id])

    respond_to do |format|
      if @event_review.update_attributes(params[:event_review])
        flash[:notice] = 'EventReview was successfully updated.'
        format.html { redirect_to(@event_review) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event_review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /event_reviews/1
  # DELETE /event_reviews/1.xml
  def destroy
    @event_review = EventReview.find(params[:id])
    @event_review.destroy

    respond_to do |format|
      format.html { redirect_to(event_reviews_url) }
      format.xml  { head :ok }
    end
  end
end
