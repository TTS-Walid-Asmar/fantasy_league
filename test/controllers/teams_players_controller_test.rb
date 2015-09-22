require 'test_helper'

class TeamsPlayersControllerTest < ActionController::TestCase
  setup do
    @teams_player = teams_players(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teams_players)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teams_player" do
    assert_difference('TeamsPlayer.count') do
      post :create, teams_player: {  }
    end

    assert_redirected_to teams_player_path(assigns(:teams_player))
  end

  test "should show teams_player" do
    get :show, id: @teams_player
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teams_player
    assert_response :success
  end

  test "should update teams_player" do
    patch :update, id: @teams_player, teams_player: {  }
    assert_redirected_to teams_player_path(assigns(:teams_player))
  end

  test "should destroy teams_player" do
    assert_difference('TeamsPlayer.count', -1) do
      delete :destroy, id: @teams_player
    end

    assert_redirected_to teams_players_path
  end
end
