class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def remove_from_league
    l = League.find(params[:lid])
    ls = User.find(params[:id]).leagues
    if ls.include?(l)
      User.find(params[:id]).leagues.delete(League.find(params[:lid]))
      @msg = "User is now removed from this league"
    else
      @msg = "User is not participating in this league"
    end
    
    respond_to do |format|
      format.html # remove_from_league.html.erb
    end
  end

  def join_league
    ls = User.find(params[:id]).leagues
    l = League.find(params[:lid])
    if (ls.include?(l))
      @msg = "User already participating in this league"
    else
      User.find(params[:id]).leagues.push(League.find(params[:lid]))
      r = Ranking.where(:user_id => params[:id], :league_id => params[:lid])[0]
      r.ranking = 1000
      r.save
      
      @msg = "User is now joined."
    end
    respond_to do |format|
      format.html # remove_from_league.html.erb
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    
    @other_leagues = League.all - @user.leagues

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
