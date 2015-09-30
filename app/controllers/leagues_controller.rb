class LeaguesController < ApplicationController
  before_action :set_league, only: [:show, :edit, :update, :destroy]
  before_action :user_drafted?, only: [:show]

  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = League.all
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
    if !user_drafted?
      @team = Team.new
      @team.name = current_user.name + @league.name

      @team.league_id = @league.id
      @team.save
      redirect_to @team
    else
      @team = Team.find_by(user_id: current_user.id, league_id: @league.id)
      @team_names = @league.fantasy_stat.find_player_names(@team.player_list)
      @team_roles = @league.fantasy_stat.find_player_roles(@team.player_list)
      @team_pics =  @league.fantasy_stat.find_player_urls(@team.player_list)
      @team_player_scores = @league.fantasy_stat.find_player_scores(@league.games, @team.player_list, @league.tournament_id)
      @rankings = @league.rank_users_by_score
    end

  end

  # GET /leagues/new
  def new
    @league = League.new
  end

  # GET /leagues/1/edit
  def edit
  end

  # POST /leagues
  # POST /leagues.json
  def create
    @league = League.new(league_params)

    respond_to do |format|
      if @league.save
        format.html { redirect_to @league, notice: 'League was successfully created.' }
        format.json { render :show, status: :created, location: @league }
      else
        format.html { render :new }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leagues/1
  # PATCH/PUT /leagues/1.json
  def update
    respond_to do |format|
      if @league.update(league_params)
        format.html { redirect_to @league, notice: 'League was successfully updated.' }
        format.json { render :show, status: :ok, location: @league }
      else
        format.html { render :edit }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league.destroy
    respond_to do |format|
      format.html { redirect_to leagues_url, notice: 'League was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def process_league
    @league = League.find(params[:id])
    @league.process_league
    redirect_to leagues_path
  end

  private

  def user_drafted?
    @league.users.include?(current_user)
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_league
    @league = League.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def league_params
    params.require(:league).permit(:name, :cost, :max_participants, :status, :start_time)
  end
end
