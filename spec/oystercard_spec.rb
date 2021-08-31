require 'oystercard'

describe Oystercard do
  
  it "responds to balance method" do 
    oystercard = Oystercard.new
    expect(oystercard).to respond_to(:balance)
  end

  it "should have an initial balance of 0" do
    oystercard = Oystercard.new 
    expect(oystercard.balance).to eq(0)
  end

  it "should respond to top_up method" do
    oystercard = Oystercard.new
    expect(oystercard).to respond_to(:top_up).with(1).argument
  end

  describe "#top_up" do

    it "should add money to my card" do
      oystercard = Oystercard.new 
      oystercard.top_up(10)
      expect(oystercard.balance).to eq(10)
    end

    it "should raise an error if we try to exceed the max balance of the card" do
      oystercard = Oystercard.new
      max_limit = Oystercard::MAX_LIMIT
      oystercard.top_up(max_limit)
      message = "Card's limit is #{max_limit}"
      expect { oystercard.top_up(1) }.to raise_error message
    end
  end

  it "responds to deduct method" do
    expect(subject).to respond_to(:deduct).with(1).argument
  end

  it "should deduct money from my card" do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    oystercard.deduct(5)
    expect(oystercard.balance).to eq(5)
  end
end

# In order to keep using public transport
# As a customer
# I want to add money to my card