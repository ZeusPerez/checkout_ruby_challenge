require 'json'

module ItemCatalog

  def self.item_in_catalog_validator(item)
    raise(NoItemFoundError.new) unless parse_catalog[item]
  end

  def self.get_price_of(item)
    item_in_catalog_validator(item)
    parse_catalog[item]["price"]
  end

  def self.parse_catalog
    JSON.parse(File.read("lib/prices.json"))
  end

end

class NoItemFoundError < StandardError
  def initialize(error_message = "The item is not on the catalog")
    super
  end
end
