class LeaguesController < ApplicationController
  # GET /leagues
  # GET /leagues.xml
  def index
    @leagues = League.all
    @leagues.sort! do |a,b|
      comp = (b.year <=> a.year)
      comp.zero? ? (sem2int(b.semester) <=> sem2int(a.semester)) : comp
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @leagues }
    end
  end



  def compete
    @league = League.find(params[:id])
    
    user1won = params[:win]
    
    if user1won != "draw"
      uid1 = params[:q1]
      uid2 = params[:q2]
    
      @user1 = User.where(:member_id => uid1)[0]
      @user2 = User.where(:member_id => uid2)[0]
    
      r1 = @user1.rankings.where(:league_id => params[:id])[0]
      r2 = @user2.rankings.where(:league_id => params[:id])[0]
    
      rank1 = Float(r1.ranking)
      rank2 = Float(r2.ranking)
    
      est1 = 1 / Float(1 + 10 ** ((rank2 - rank1) / 400))
      est2 = 1 / Float(1 + 10 ** ((rank1 - rank2) / 400))
        
      if user1won == "true"
        sc1 = 1
        sc2 = 0
      else
        sc1 = 0
        sc2 = 1
      end
    
      r1.ranking = Integer((rank1 + 10 * (sc1 - est1)).round)
      r2.ranking = Integer((rank2 + 10 * (sc2 - est2)).round) 
    

    end
    
    respond_to do |format|
      format.html { redirect_to(@league, :notice => 'Match outcome was recodred.') }
    end
  end

  # GET /leagues/1
  # GET /leagues/1.xml
  def show
    @league = League.find(params[:id])
    @users = @league.users
    @users.sort! { |a,b| b.rankings.where(:league_id => @league.id)[0].ranking <=> 
      a.rankings.where(:league_id => @league.id)[0].ranking }
      
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @league }
    end
  end

  # GET /leagues/new
  # GET /leagues/new.xml
  def new
    @league = League.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @league }
    end
  end

  # GET /leagues/1/edit
  def edit
    @league = League.find(params[:id])
  end

  # POST /leagues
  # POST /leagues.xml
  def create
    @league = League.new(params[:league])

    respond_to do |format|
      if @league.save
        format.html { redirect_to(@league, :notice => 'League was successfully created.') }
        format.xml  { render :xml => @league, :status => :created, :location => @league }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @league.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /leagues/1
  # PUT /leagues/1.xml
  def update
    @league = League.find(params[:id])

    respond_to do |format|
      if @league.update_attributes(params[:league])
        format.html { redirect_to(@league, :notice => 'League was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @league.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.xml
  def destroy
    @league = League.find(params[:id])
    @league.destroy

    respond_to do |format|
      format.html { redirect_to(leagues_url) }
      format.xml  { head :ok }
    end
  end
end
