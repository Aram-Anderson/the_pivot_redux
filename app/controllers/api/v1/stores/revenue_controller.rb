class Api::V1::Stores::RevenueController < ApplicationController
  def show
    revenue = Merchant.find(params[:id]).total_revenue(revenue_params)
    render json: revenue, serializer: MerchantRevenueSerializer
  end

  private

  def revenue_params
    if params[:date]
      params[:created_at] = params[:date]
      params.permit(:merchant_id, :created_at)
    else
      params.permit(:merchant_id)
    end
  end
end
