require_relative '../lib/shopping_cart'

describe ShoppingCart do

  subject { ShoppingCart.new }

  describe "#add" do
    it "adds the product to the shopping list" do
      subject.add("MUG")
      subject.add("MUG")
      subject.add("TSHIRT")
      expect(subject.shopping_list.keys).to include("MUG")
      expect(subject.shopping_list["MUG"]).to eq(2)
    end
  end
end
