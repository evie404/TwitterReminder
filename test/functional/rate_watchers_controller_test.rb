require 'test_helper'

class RateWatchersControllerTest < ActionController::TestCase
  setup do
    @rate_watcher = rate_watchers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rate_watchers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rate_watcher" do
    assert_difference('RateWatcher.count') do
      post :create, rate_watcher: {  }
    end

    assert_redirected_to rate_watcher_path(assigns(:rate_watcher))
  end

  test "should show rate_watcher" do
    get :show, id: @rate_watcher
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rate_watcher
    assert_response :success
  end

  test "should update rate_watcher" do
    put :update, id: @rate_watcher, rate_watcher: {  }
    assert_redirected_to rate_watcher_path(assigns(:rate_watcher))
  end

  test "should destroy rate_watcher" do
    assert_difference('RateWatcher.count', -1) do
      delete :destroy, id: @rate_watcher
    end

    assert_redirected_to rate_watchers_path
  end
end
