require_relative '../lib/item_catalog'

describe ItemCatalog do
  describe "#get_price_of" do
    it "extracts the price of a item from the JSON prices file" do
      price = ItemCatalog.get_price_of("MUG")
      expect(price).to eq(7.5)
    end

    it "raises error if the item is not in the catalog" do
      expect { ItemCatalog.get_price_of("FAKE_ITEM") }.to raise_error(NoItemFoundError)
    end
  end

  describe "item_in_catalog_validator" do
    it "doesn't raise error if the item is in the catalog" do
      expect { ItemCatalog.item_in_catalog_validator("MUG") }.to_not raise_error
    end

    it "raises error if the item is not in the catalog" do
      expect { ItemCatalog.item_in_catalog_validator("FAKE_ITEM") }.to raise_error(NoItemFoundError)
    end
  end
end
