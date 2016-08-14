class WeatherDataController < ApplicationController
  before_action :set_weather_datum, only: [:show, :edit, :update, :destroy]

  # GET /weather_data
  # GET /weather_data.json
  def index
    @weather_data = WeatherDatum.all
  end

  # GET /weather_data/1
  # GET /weather_data/1.json
  def show
  end

  # GET /weather_data/new
  def new
    @weather_datum = WeatherDatum.new
  end

  # GET /weather_data/1/edit
  def edit
  end

  # POST /weather_data
  # POST /weather_data.json
  def create
    @weather_datum = WeatherDatum.new(weather_datum_params)

    respond_to do |format|
      if @weather_datum.save
        format.html { redirect_to @weather_datum, notice: 'Weather datum was successfully created.' }
        format.json { render :show, status: :created, location: @weather_datum }
      else
        format.html { render :new }
        format.json { render json: @weather_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weather_data/1
  # PATCH/PUT /weather_data/1.json
  def update
    respond_to do |format|
      if @weather_datum.update(weather_datum_params)
        format.html { redirect_to @weather_datum, notice: 'Weather datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @weather_datum }
      else
        format.html { render :edit }
        format.json { render json: @weather_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_data/1
  # DELETE /weather_data/1.json
  def destroy
    @weather_datum.destroy
    respond_to do |format|
      format.html { redirect_to weather_data_url, notice: 'Weather datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather_datum
      @weather_datum = WeatherDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weather_datum_params
      params.require(:weather_datum).permit(:observation_date)
    end
end
