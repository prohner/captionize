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
    @vote = Vote.get_vote_for_user_and_caption(session[:user_id], params[:id])
    @vote.is_up = params[:u]
    @vote.save
    @caption = Caption.find(params[:id])
    #redirect_to :action => 'index'
    respond_to { |format| format.js }
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
    logger.error("get_session_user_id 1 (#{session[:user_id]})")

    #session[:username] = User.find(8).name
    if session[:user_id] == nil || !User.exists?(session[:user_id])
      if params[:username] && !User.exists?(["name = ?", params[:username]])
        logger.error("get_session_user_id 2")
        new_user = User.new(:name => params[:username], :email => 'whatever@wherever.com')
      else
        logger.error("get_session_user_id 3")
        new_user = User.find_by_name(:name => "Billy Bob", :email => 'billy@bob.com')
      end
      logger.error("get_session_user_id 4")
      new_user.save
      logger.error("My new user id is #{new_user.id}")
      session[:user_id] = new_user.id
      session[:username] = new_user.name
    end
    
    session[:user_id]
  end

end
