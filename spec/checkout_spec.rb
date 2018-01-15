require_relative '../lib/checkout'

describe Checkout do

  let(:marketing_lambda) do
    lambda do |shopping_list|
      (shopping_list["VOUCHER"].to_i / 2) * ItemCatalog.get_price_of("VOUCHER")
    end
  end

  let(:cfo_lambda) do
    lambda do |shopping_list|
      shopping_list["TSHIRT"] if shopping_list["TSHIRT"].to_i >= 3
    end
  end

  let(:marketing_rule) { Rule.new(marketing_lambda) }
  let(:cfo_rule) { Rule.new(cfo_lambda) }

  subject { Checkout.new([marketing_rule, cfo_rule]) }

  it "returns the result of a checkout for a VOUCHER, TSHIRT and a MUG" do
    subject.scan("VOUCHER")
    subject.scan("TSHIRT")
    subject.scan("MUG")
    expect(subject.total).to eq(32.5)
  end

  it "returns the result of a checkout for two VOUCHER and a TSHIRT" do
    subject.scan("VOUCHER")
    subject.scan("TSHIRT")
    subject.scan("VOUCHER")
    expect(subject.total).to eq(25)
  end

  it "returns the result of a checkout for four TSHIRT and a VOUCHER" do
    subject.scan("TSHIRT")
    subject.scan("TSHIRT")
    subject.scan("TSHIRT")
    subject.scan("VOUCHER")
    subject.scan("TSHIRT")
    expect(subject.total).to eq(81)
  end

  it "returns the result of a checkout for three VOUCHER, three TSHIRT and a MUG" do
    subject.scan("VOUCHER")
    subject.scan("TSHIRT")
    subject.scan("VOUCHER")
    subject.scan("VOUCHER")
    subject.scan("MUG")
    subject.scan("TSHIRT")
    subject.scan("TSHIRT")
    expect(subject.total).to eq(74.5)
  end

  it "returns the result for an empty shopping list" do
    expect(subject.total).to eq(0)
  end
end
