require 'test_helper'

class FeesControllerTest < ActionController::TestCase
  setup do
    @fee = fees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fee" do
    assert_difference('Fee.count') do
      post :create, fee: { fee_name: @fee.fee_name }
    end

    assert_redirected_to fee_path(assigns(:fee))
  end

  test "should show fee" do
    get :show, id: @fee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fee
    assert_response :success
  end

  test "should update fee" do
    patch :update, id: @fee, fee: { fee_name: @fee.fee_name }
    assert_redirected_to fee_path(assigns(:fee))
  end

  test "should destroy fee" do
    assert_difference('Fee.count', -1) do
      delete :destroy, id: @fee
    end

    assert_redirected_to fees_path
  end
end
