require 'test_helper'

class PoliciesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:policies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create policy" do
    assert_difference('Policy.count') do
      post :create, :policy => { }
    end

    assert_redirected_to policy_path(assigns(:policy))
  end

  test "should show policy" do
    get :show, :id => policies(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => policies(:one).id
    assert_response :success
  end

  test "should update policy" do
    put :update, :id => policies(:one).id, :policy => { }
    assert_redirected_to policy_path(assigns(:policy))
  end

  test "should destroy policy" do
    assert_difference('Policy.count', -1) do
      delete :destroy, :id => policies(:one).id
    end

    assert_redirected_to policies_path
  end
end
