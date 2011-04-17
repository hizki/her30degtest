class PagesController < ApplicationController
  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  
  def backy
    uid1 = params[:q1]
    uid2 = params[:q2]
    user1won = params[:q3]
    
    @user1 = User.find(uid1)
    @user2 = User.find(uid2)
    
    rank1 = Float(@user1.raking)
    rank2 = Float(@user2.raking)
    est1 = 1 / Float(1 + 10 ** ((rank2 - rank1) / 400))
    est2 = 1 / Float(1 + 10 ** ((rank1 - rank2) / 400))
    
    sc1 = 0
    sc2 = 0
    
    if user1won == "true"
      sc1 = 1
    else
      sc2 = 1
    end
    
    @user1.raking = Integer((@user1.raking + 10 * (sc1 - est1)).round)
    @user2.raking = Integer((@user2.raking + 10 * (sc2 - est2)).round) 
    
    @user1.save
    @user2.save
    
    respond_to do |format|
      format.html # backy.html.erb
    end
  end
      

  

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to(@page, :notice => 'Page was successfully created.') }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to(@page, :notice => 'Page was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(pages_url) }
      format.xml  { head :ok }
    end
  end
end
