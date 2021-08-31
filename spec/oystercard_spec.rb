require 'oystercard'

describe Oystercard do
  
  it "responds to balance method" do 
    oystercard = Oystercard.new
    expect(oystercard).to respond_to(:balance)
  end

  it "should have a balance of 0" do
    oystercard = Oystercard.new 
    expect(oystercard.balance).to eq(0)
  end

  it "should respond to top_up method" do
    oystercard = Oystercard.new
    expect(oystercard).to respond_to(:top_up).with(1).argument
  end

  it "should add money to my card" do
    oystercard = Oystercard.new 
    oystercard.top_up(10)
    expect(oystercard.balance).to eq(10)
  end
end

# In order to keep using public transport
# As a customer
# I want to add money to my card