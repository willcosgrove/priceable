require "spec_helper"

describe Priceable do
  let(:llama) { Llama.new }

  it "should create a getter method" do
    llama.price_in_cents = 10000
    llama.price.should == 100
  end

  it "should create a setter method" do
    llama.price = 200.10
    llama.price_in_cents.should == 20010
  end

  it "should return 0.0 if nil" do
    llama.price.should == 0.0
  end  

  it "should set it as attr_accessible" do
    Llama.accessible_attributes.to_a.should include("price")
  end

  it "should not set it as attr_accessible if there are no accessible attributes already set" do
    Pig.accessible_attributes.to_a.should_not include("price")
  end

  it "should raise an ArgumentError if there is no database field set" do
    lambda { Pig.send(:priceable, :cost) }.should raise_error(ArgumentError)
  end
end