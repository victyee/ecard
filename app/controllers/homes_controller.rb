class HomesController < ApplicationController

  # GET /homes
  # GET /homes.json
  def index
    @cards = Card.all
  end

  def login
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def home_params
    #   params[:home]
    # end
end
