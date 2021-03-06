class StocksController < ApplicationController

 def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/stock_result'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Stock (Ticker) Symbol not found or inexistent"
          format.js { render partial: 'users/stock_result'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a Stock (Ticker) Symbol to search"
        format.js { render partial: 'users/stock_result'}
      end
    end
 end

end
