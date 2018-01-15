require 'item_catalog'

class ShoppingCart

  attr_reader :shopping_list

  def initialize
    @shopping_list = {}
  end

  def add(item)
    shopping_list[item] = shopping_list[item].to_i + 1
  end
end
