class PagesController < ApplicationController
  skip_before_filter :check_session, :only => [:login, :authenticate]

  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  def authenticate
		@username = params[:login]
    @pass = params[:pass]
    if @username == "admin"
      if Digest::SHA1.hexdigest(@pass) == "9189df0c394b3632e4e34a80f685b932a029785b"
  			session[:loggedin] = true
  			redirect_to :controller => 'leagues', :action => 'index'
			else
			  flash[:notice] = "Invalid User/Password"
  			redirect_to :action => 'login'
  		end
  	else
			flash[:notice] = "Invalid User/Password"
			redirect_to :action => 'login'
  	end
  end

  def login
    # TODO: check if session doesnt already have a login
    
    respond_to do |format|
      format.html
    end
  end
  
  def logout
    session[:loggedin] = false
    
    redirect_to :action => 'login'
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

  def search
    @query = params[:q]
    @user_results = []
    @user_results.concat(User.find(:all, :conditions => ["name like ?" , "%" + @query + "%"]))
    @user_results.concat(User.find(:all, :conditions => ["member_id like ?" , "%" + @query + "%"]))
    @user_results.concat(User.find(:all, :conditions => ["email like ?" , "%" + @query + "%"]))

    @league_results = []
    @league_results.concat(League.find(:all, :conditions => ["game like ?" , "%" + @query + "%"]))
    @league_results.concat(League.find(:all, :conditions => ["semester like ?" , "%" + @query + "%"]))
    @league_results.concat(League.find(:all, :conditions => ["year like ?" , @query]))
    
    
    respond_to do |format|
      format.html
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
