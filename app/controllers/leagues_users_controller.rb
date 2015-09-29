class LeaguesUsersController < ApplicationController
  before_action :set_leagues_user, only: [:show, :edit, :update, :destroy]

  # GET /leagues_users
  # GET /leagues_users.json
  def index
    @leagues_users = LeaguesUser.all
  end

  # GET /leagues_users/1
  # GET /leagues_users/1.json
  def show
  end

  # GET /leagues_users/new
  def new
    @league = League.find(params[:league_id])
    if @league.users.include?(current_user)
      redirect_to @league
    else
      @leagues_user = LeaguesUser.new
      @leagues_user.user = current_user
      @leagues_user.league = @league

      respond_to do |format|
        if @leagues_user.save
          format.html { redirect_to @league, notice: 'Leagues user was successfully created.' }
          format.json { render :show, status: :created, location: @leagues_user }
        else
          format.html { render :new }
          format.json { render json: @leagues_user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # GET /leagues_users/1/edit
  def edit
  end

  # POST /leagues_users
  # POST /leagues_users.json
  def create
    @leagues_user = LeaguesUser.new(leagues_user_params)

    respond_to do |format|
      if @leagues_user.save
        format.html { redirect_to @leagues_user}
        format.json { render :show, status: :created, location: @leagues_user }
      else
        format.html { render :new }
        format.json { render json: @leagues_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leagues_users/1
  # PATCH/PUT /leagues_users/1.json
  def update
    respond_to do |format|
      if @leagues_user.update(leagues_user_params)
        format.html { redirect_to @leagues_user}
        format.json { render :show, status: :ok, location: @leagues_user }
      else
        format.html { render :edit }
        format.json { render json: @leagues_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues_users/1
  # DELETE /leagues_users/1.json
  def destroy
    @leagues_user.destroy
    respond_to do |format|
      format.html { redirect_to leagues_users_url}
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_leagues_user
    @leagues_user = LeaguesUser.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def leagues_user_params
    params.require(:leagues_user).permit(:league_id, :user_id)
  end
end
