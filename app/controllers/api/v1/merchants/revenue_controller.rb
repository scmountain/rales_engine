class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.highest_revenue(params[:quantity])
  end

  def date
    total_revenue = Merchant.total_revenue_for_date(params[:date])
    render json: {"total_revenue": format_total(total_revenue)}
  end

  def total_revenue_per_merchant
    total = Merchant.find(params[:merchant_id]).total_revenue(params[:date])
    render json: {"revenue": format_total(total)}
  end

  def format_total(total)
    (total.to_f / 100).round(2).to_s
  end
end
