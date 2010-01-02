class PicturesController < ApplicationController
    before_filter :get_session_user_id
  # GET /pictures
  # GET /pictures.xml
  def index
    @pictures = Picture.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pictures }
    end
  end

  def picture
    @picture = Picture.find(params[:id])
    send_data(@picture.picture_data,
              :filename => @picture.path_to_picture,
              :type => @picture.content_type,
              :disposition => "inline")
  end
  
  # GET /pictures/1
  # GET /pictures/1.xml
  def show
    @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @picture }
    end
  end

  def add_caption
    new_caption_id = "new_caption_%d" % params[:picture_id]
    @current_caption = Caption.create(:headline => params[new_caption_id],
                                      :picture_id => params[:picture_id],
                                      :user_id => session[:user_id])
    @current_caption.save
    @picture = Picture.find(params[:picture_id])
    @captions = @picture.captions
    
    #redirect_to :action => 'picture', :id => params[:picture_id]
    respond_to { |format| format.js }
  end
  
  def add_new_picture
    @picture = Picture.create()
  end

  def caption_vote
    logger.error('going')
    @vote = Vote.get_vote_for_user_and_caption(session[:user_id], params[:id])
    @vote.is_up = params[:u]
    @vote.save
    @caption = Caption.find(params[:id])
    #redirect_to :action => 'index'
  end

  def force_user_id
    set_session_user_id(params[:id])
    redirect_to :action => 'index'
  end

  # GET /pictures/new
  # GET /pictures/new.xml
  def new
    @picture = Picture.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    @picture = Picture.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.xml
  def create
    @picture = Picture.new(params[:picture])
    @picture.user_id = session[:user_id]

    respond_to do |format|
      if @picture.save
        flash[:notice] = 'Picture was successfully created.'
        format.html { redirect_to(@picture) }
        format.xml  { render :xml => @picture, :status => :created, :location => @picture }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.xml
  def update
    @picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        flash[:notice] = 'Picture was successfully updated.'
        format.html { redirect_to(@picture) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.xml
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to(pictures_url) }
      format.xml  { head :ok }
    end
  end

private
  def get_session_user_id
    if ! session[:user_id]
      set_session_user_id(1)
    end
    session[:user_id]
  end

  def set_session_user_id(new_id)
    x = User.find(new_id)

    if x.id == nil?    
      session[:user_id] = new_id 
    else
      session[:user_id] = "1"
    end
  
    if "1" == session[:user_id] 
      session[:username] = 'Preston'
    else
      session[:username] = 'Alexis'
    end  
  end

end
