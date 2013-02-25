require 'test_helper'

class OrtesControllerTest < ActionController::TestCase
  setup do
    @orte = ortes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ortes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orte" do
    assert_difference('Orte.count') do
      post :create, orte: { comment: @orte.comment, day: @orte.day, descr: @orte.descr, env: @orte.env, name: @orte.name, p_name: @orte.p_name }
    end

    assert_redirected_to orte_path(assigns(:orte))
  end

  test "should show orte" do
    get :show, id: @orte
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @orte
    assert_response :success
  end

  test "should update orte" do
    put :update, id: @orte, orte: { comment: @orte.comment, day: @orte.day, descr: @orte.descr, env: @orte.env, name: @orte.name, p_name: @orte.p_name }
    assert_redirected_to orte_path(assigns(:orte))
  end

  test "should destroy orte" do
    assert_difference('Orte.count', -1) do
      delete :destroy, id: @orte
    end

    assert_redirected_to ortes_path
  end
end
