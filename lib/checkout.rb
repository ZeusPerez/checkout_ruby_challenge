require 'rule'
require 'shopping_cart'

class Checkout

  def initialize(rules)
    @rules = rules
    @shopping_cart = ShoppingCart.new
  end

  def scan(item)
    @shopping_cart.add(item)
  end

  def total
    calculate_total - calculate_discount
  end

  protected

  def calculate_total
    total_per_item = @shopping_cart.shopping_list.map do |item, number|
      number * ItemCatalog.get_price_of(item)
    end
    total_per_item.inject(0, :+)
  end

  def calculate_discount
    @rules.map { |rule| rule.discount(@shopping_cart.shopping_list) }.inject(0, :+)
  end

end
