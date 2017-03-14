class Api::V1::Merchants::FinderController < ApplicationController
  def show
    finder = params.keys[0]
    if finder.downcase == "id"
      render json: Merchant.find(params[finder.downcase])
    else
      render json: Merchant.find_by(params.keys.first => params[finder])
    end
  end

  def index
    finder = params.keys[0]
    render json: Merchant.where("lower(#{finder}) = ?", params[finder].downcase)
  end

  def random
    render json: Merchant.all.sample
  end
end
