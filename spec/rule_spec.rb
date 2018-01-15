require_relative '../lib/rule'
require_relative '../lib/item_catalog'

describe Rule do

  describe "marketing rule" do
    let(:marketing_lambda) do
      lambda do |shopping_list|
        (shopping_list["VOUCHER"].to_i / 2) * ItemCatalog.get_price_of("VOUCHER")
      end
    end

    subject { Rule.new(marketing_lambda) }

    it "returns the discount for 3 VOUCHERS" do
      shopping_list = { "VOUCHER" => 3 }
      expect(subject.discount(shopping_list)).to eq(5)
    end

    it "returns the discount for 20 VOUCHERS" do
      shopping_list = { "VOUCHER" => 20 }
      expect(subject.discount(shopping_list)).to eq(50)
    end

    it "returns the discount for one VOUCHERS" do
      shopping_list = { "VOUCHER" => 1 }
      expect(subject.discount(shopping_list)).to eq(0)
    end

    it "returns the discount for wiht no VOUCHERS" do
      shopping_list = { "MUG" => 1 }
      expect(subject.discount(shopping_list)).to eq(0)
    end
  end

  describe "cfo rule" do
    let(:cfo_lambda) do
      lambda do |shopping_list|
        shopping_list["TSHIRT"] if shopping_list["TSHIRT"] >= 3
      end
    end

    subject { Rule.new(cfo_lambda) }

    it "returns the discount for 3 TSHIRT" do
      shopping_list = { "TSHIRT" => 3 }
      expect(subject.discount(shopping_list)).to eq(3)
    end

    it "returns the discount for 20 TSHIRT" do
      shopping_list = { "TSHIRT" => 20 }
      expect(subject.discount(shopping_list)).to eq(20)
    end

    it "returns the discount for one TSHIRT" do
      shopping_list = { "TSHIRT" => 1 }
      expect(subject.discount(shopping_list)).to eq(0)
    end

    it "returns the discount for wiht no TSHIRT" do
      shopping_list = { "TSHIRT" => 1 }
      expect(subject.discount(shopping_list)).to eq(0)
    end

  end
end
