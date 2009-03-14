require 'test_helper'

class EmailConfigsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:email_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create email_config" do
    assert_difference('EmailConfig.count') do
      post :create, :email_config => { }
    end

    assert_redirected_to email_config_path(assigns(:email_config))
  end

  test "should show email_config" do
    get :show, :id => email_configs(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => email_configs(:one).id
    assert_response :success
  end

  test "should update email_config" do
    put :update, :id => email_configs(:one).id, :email_config => { }
    assert_redirected_to email_config_path(assigns(:email_config))
  end

  test "should destroy email_config" do
    assert_difference('EmailConfig.count', -1) do
      delete :destroy, :id => email_configs(:one).id
    end

    assert_redirected_to email_configs_path
  end
end
