class DegreesController < ApplicationController
  before_action :set_degree, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @degrees = Degree.all
    respond_with(@degrees)
  end

  def show
    respond_with(@degree)
  end

  def new
    @degree = Degree.new
    respond_with(@degree)
  end

  def edit
  end

  def create
    @degree = Degree.new(degree_params)
    @degree.save
    respond_with(@degree)
  end

  def update
    @degree.update(degree_params)
    respond_with(@degree)
  end

  def destroy
    @degree.destroy
    respond_with(@degree)
  end

  private
    def set_degree
      @degree = Degree.find(params[:id])
    end

    def degree_params
      params.require(:degree).permit(:value, :activity, :description)
    end
end
