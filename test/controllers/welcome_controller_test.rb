require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get upcoming" do
    get :upcoming
    assert_response :success
  end

  test "should get live" do
    get :live
    assert_response :success
  end

  test "should get history" do
    get :history
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get us" do
    get :us
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

end
