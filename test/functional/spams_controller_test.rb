require 'test_helper'

class SpamsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spam" do
    assert_difference('Spam.count') do
      post :create, :spam => { }
    end

    assert_redirected_to spam_path(assigns(:spam))
  end

  test "should show spam" do
    get :show, :id => spams(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => spams(:one).id
    assert_response :success
  end

  test "should update spam" do
    put :update, :id => spams(:one).id, :spam => { }
    assert_redirected_to spam_path(assigns(:spam))
  end

  test "should destroy spam" do
    assert_difference('Spam.count', -1) do
      delete :destroy, :id => spams(:one).id
    end

    assert_redirected_to spams_path
  end
end
