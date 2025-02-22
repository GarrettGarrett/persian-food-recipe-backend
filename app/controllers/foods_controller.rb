class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :update, :destroy]

  # GET /foods
  def index
    # @foods = Food.all
    
    render json: get_foods
  end

  # GET /foods/1
  def show
    render json: @food
  end

  # POST /foods
  def create
    @food = Food.new(food_params)

    if @food.save
      render json: get_foods, status: :created, location: @food
    else
      render json: @food.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /foods/1
  def update
    if @food.update(food_params)
      render json: get_foods
    else
      render json: @food.errors, status: :unprocessable_entity
    end
  end

  # DELETE /foods/1
  def destroy
    @food.destroy
    render json: get_foods
  end

  private
    def get_foods
      Food.order "created_at DESC" 
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    

    # Only allow a list of trusted parameters through.
    def food_params
      params.require(:food).permit(:title, :url, :img, :directions => [], :ingredients => [])
    end
end
