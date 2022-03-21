class UserStocksController < ApplicationController
  before_action :set_user_stock, only: %i[ show edit update ]

  # GET /user_stocks or /user_stocks.json
  def index
    @user_stocks = UserStock.all
  end

  # GET /user_stocks/1 or /user_stocks/1.json
  def show
  end

  # GET /user_stocks/new
  def new
    @user_stock = UserStock.new
  end

  # GET /user_stocks/1/edit
  def edit
  end

  # POST /user_stocks or /user_stocks.json
  def create
    if params[:stock_id].present?
      @user_stock = UserStock.new(stock_id: params[:stock_id], user: current_user)
    else
      stock = Stock.find_by_ticker(params[:stock_ticker])
      if stock
        @user_stock = UserStock.new(stock: stock, user: current_user)      
      
      else 
        stock = Stock.new_from_lookup(params[:stock_ticker])
        if stock.save
          @user_stock = UserStock.new(user: current_user, stock:stock)
        else
          @user_stock = nil
          flash[:error] = 'Stock is not available'
        end
    
      end

    end
   

    respond_to do |format|
      if @user_stock.save
        format.html { redirect_to my_portfolio_path, notice: "Stock #{@user_stock.stock.ticker} stock was successfully added" }
        format.json { render :show, status: :created, location: @user_stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_stocks/1 or /user_stocks/1.json
  def update
    respond_to do |format|
      if @user_stock.update(user_stock_params)
        format.html { redirect_to user_stock_url(@user_stock), notice: "User stock was successfully updated." }
        format.json { render :show, status: :ok, location: @user_stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_stocks/1 or /user_stocks/1.json
  def destroy

    @stock = UserStock.where(:stock_id => params[:id]).first

    @stock.destroy

    respond_to do |format|
      format.html { redirect_to my_portfolio_path, notice: "User stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_stock
      @user_stock = UserStock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_stock_params
      params.require(:user_stock).permit(:user_id, :stock_id)
    end
end
