require 'test_helper'

class LeaguesUsersControllerTest < ActionController::TestCase
  setup do
    @leagues_user = leagues_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leagues_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create leagues_user" do
    assert_difference('LeaguesUser.count') do
      post :create, leagues_user: { league_id: @leagues_user.league_id, user_id: @leagues_user.user_id }
    end

    assert_redirected_to leagues_user_path(assigns(:leagues_user))
  end

  test "should show leagues_user" do
    get :show, id: @leagues_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @leagues_user
    assert_response :success
  end

  test "should update leagues_user" do
    patch :update, id: @leagues_user, leagues_user: { league_id: @leagues_user.league_id, user_id: @leagues_user.user_id }
    assert_redirected_to leagues_user_path(assigns(:leagues_user))
  end

  test "should destroy leagues_user" do
    assert_difference('LeaguesUser.count', -1) do
      delete :destroy, id: @leagues_user
    end

    assert_redirected_to leagues_users_path
  end
end
