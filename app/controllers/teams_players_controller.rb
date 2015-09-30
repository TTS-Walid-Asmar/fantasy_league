class TeamsPlayersController < ApplicationController
  before_action :set_teams_player, only: [:show, :edit, :update, :destroy]

  # GET /teams_players
  # GET /teams_players.json
  def index
    @teams_players = TeamsPlayer.all
  end

  # GET /teams_players/1
  # GET /teams_players/1.json
  def show


  end

  # GET /teams_players/new
  def new

    @team = Team.find(params[:team_id])
    @player_id = params[:player_id].to_i

    @player_cost = params[:player_cost].to_i


    if @team.can_add?(@player_id)

      @team.player_list.push(@player_id)
      @team.save
      redirect_to team_path(id: @team.id, position: params[:position])
    else
      flash[:notice] = "Sorry this player could not be added."

      redirect_to team_path(@team, position: params[:position])
    end

  end

  # GET /teams_players/1/edit
  def edit
  end

  # POST /teams_players
  # POST /teams_players.json
  def create
    @teams_player = TeamsPlayer.new(teams_player_params)

    respond_to do |format|
      if @teams_player.save
        format.html { redirect_to @teams_player, notice: 'Teams player was successfully created.' }
        format.json { render :show, status: :created, location: @teams_player }
      else
        format.html { render :new }
        format.json { render json: @teams_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams_players/1
  # PATCH/PUT /teams_players/1.json
  def update
    respond_to do |format|
      if @teams_player.update(teams_player_params)
        format.html { redirect_to @teams_player, notice: 'Teams player was successfully updated.' }
        format.json { render :show, status: :ok, location: @teams_player }
      else
        format.html { render :edit }
        format.json { render json: @teams_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams_players/1
  # DELETE /teams_players/1.json
  def destroy
    @teams_player.destroy
    respond_to do |format|
      format.html { redirect_to teams_players_url, notice: 'Teams player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_teams_player
    @teams_player = TeamsPlayer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def teams_player_params
    params[:teams_player, :team_id, :player_id]
  end
end
