require 'test_helper'

class BillingSettingsControllerTest < ActionController::TestCase
  setup do
    @billing_setting = billing_settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:billing_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create billing_setting" do
    assert_difference('BillingSetting.count') do
      post :create, billing_setting: {  }
    end

    assert_redirected_to billing_setting_path(assigns(:billing_setting))
  end

  test "should show billing_setting" do
    get :show, id: @billing_setting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @billing_setting
    assert_response :success
  end

  test "should update billing_setting" do
    put :update, id: @billing_setting, billing_setting: {  }
    assert_redirected_to billing_setting_path(assigns(:billing_setting))
  end

  test "should destroy billing_setting" do
    assert_difference('BillingSetting.count', -1) do
      delete :destroy, id: @billing_setting
    end

    assert_redirected_to billing_settings_path
  end
end
