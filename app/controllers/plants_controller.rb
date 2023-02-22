class PlantsController < ApplicationController
  def new
    @garden = Garden.find(params[:garden_id])
    @plant = Plant.new
  end

  def create
    @garden = Garden.find(params[:garden_id])
    @plant = Plant.new(plant_params)
    @plant.garden = @garden
    @plant.save

    respond_to do |format|
      if @plant.save
        format.html { redirect_to garden_url(@garden), notice: "Plant was successfully created." }
        format.json { render :show, status: :created, location: @garden }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @plant.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def plant_params
      params.require(:plant).permit(:name)
    end
end
