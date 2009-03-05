require 'test_helper'

class TestimonialsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:testimonials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create testimonial" do
    assert_difference('Testimonial.count') do
      post :create, :testimonial => { }
    end

    assert_redirected_to testimonial_path(assigns(:testimonial))
  end

  test "should show testimonial" do
    get :show, :id => testimonials(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => testimonials(:one).id
    assert_response :success
  end

  test "should update testimonial" do
    put :update, :id => testimonials(:one).id, :testimonial => { }
    assert_redirected_to testimonial_path(assigns(:testimonial))
  end

  test "should destroy testimonial" do
    assert_difference('Testimonial.count', -1) do
      delete :destroy, :id => testimonials(:one).id
    end

    assert_redirected_to testimonials_path
  end
end
