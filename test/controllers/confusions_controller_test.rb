require 'test_helper'

class ConfusionsControllerTest < ActionController::TestCase
  setup do
    @confusion = confusions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:confusions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create confusion" do
    assert_difference('Confusion.count') do
      post :create, confusion: {  }
    end

    assert_redirected_to confusion_path(assigns(:confusion))
  end

  test "should show confusion" do
    get :show, id: @confusion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @confusion
    assert_response :success
  end

  test "should update confusion" do
    patch :update, id: @confusion, confusion: {  }
    assert_redirected_to confusion_path(assigns(:confusion))
  end

  test "should destroy confusion" do
    assert_difference('Confusion.count', -1) do
      delete :destroy, id: @confusion
    end

    assert_redirected_to confusions_path
  end
end
