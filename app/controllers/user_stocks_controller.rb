class UserStocksController < ApplicationController
  before_action :set_userstock, only: [:show, :edit, :update, :destroy]

  def index
    @user_stock = UserStock.all
  end

  def show
  end

  def new
    @user_stock = UserStock.new
  end

  def edit
  end

  def create
    if params[:stock_id].present?
      @user_stock = UserStock.new(user: current_user, stock_id: params[:stock_id])
    else
      stock = Stock.find_by_ticker(params[:stock_ticker])
      if stock
        @user_stock = UserStock.new(user: current_user, stock: stock)
      else
        stock = Stock.new_from_lookup(params[:stock_ticker])
        if stock.save
          @user_stock = UserStock.new(user: current_user, stock: stock)
        else
          @user_stock = nil
          flash[:error] = 'Stock is not available'
        end
      end
    end

    respond_to do |format|
      if @user_stock.save
        format.html { redirect_to my_portfolio_path, 
                      notice: "Stock #{@user_stock.stock.ticker} was successfully added" }
        format.json { render :show, status: :created, location: @user_stock }
      else
        format.html { render :new }
        format.json { render json: @user_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /userstocks/1
  # PATCH/PUT /userstocks/1.json
  def update
    respond_to do |format|
      if @userstock.update(userstock_params)
        format.html { redirect_to @userstock, notice: 'Userstock was successfully updated.' }
        format.json { render :show, status: :ok, location: @userstock }
      else
        format.html { render :edit }
        format.json { render json: @userstock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /userstocks/1
  # DELETE /userstocks/1.json
  def destroy
    @user_stock.destroy
    respond_to do |format|
      format.html { redirect_to my_portfolio_path, notice: 'Stock was successfully removed from portfolio.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_userstock
      @user_stock = UserStock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def userstock_params
      params.require(:userstock).permit(:user_id, :stock_id)
    end
end
