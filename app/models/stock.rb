class Stock < ActiveRecord::Base
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  def self.new_from_lookup(ticker_symbol)
    StockQuote::Stock.new(api_key: 'pk_d253aafd6f364abbb8f67e23b348b8e9')
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    looked_up_stock_company_name = StockQuote::Stock.company(ticker_symbol)

    return nil unless looked_up_stock.symbol

    new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock_company_name.company_name)
    new_stock.last_price =new_stock.price
    new_stock
  end

  def price 
    closing_price = StockQuote::Stock.quote(ticker).close
    return "#{closing_price} closing" if closing_price

    opening_price = StockQuote::Stock.quote(ticker).open
    return "#{opening_price} opening" if opening_price

    'Unvailable'

  end
end
