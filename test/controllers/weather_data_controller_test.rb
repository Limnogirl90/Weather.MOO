require 'test_helper'

class WeatherDataControllerTest < ActionController::TestCase
  setup do
    @weather_datum = weather_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weather_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weather_datum" do
    assert_difference('WeatherDatum.count') do
      post :create, weather_datum: { observation_date: @weather_datum.observation_date }
    end

    assert_redirected_to weather_datum_path(assigns(:weather_datum))
  end

  test "should show weather_datum" do
    get :show, id: @weather_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weather_datum
    assert_response :success
  end

  test "should update weather_datum" do
    patch :update, id: @weather_datum, weather_datum: { observation_date: @weather_datum.observation_date }
    assert_redirected_to weather_datum_path(assigns(:weather_datum))
  end

  test "should destroy weather_datum" do
    assert_difference('WeatherDatum.count', -1) do
      delete :destroy, id: @weather_datum
    end

    assert_redirected_to weather_data_path
  end
end
