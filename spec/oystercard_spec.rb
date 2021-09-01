require 'oystercard'

describe Oystercard do
  
  it "responds to balance method" do 
    expect(subject).to respond_to(:balance)
  end

  it "should have an initial balance of 0" do
    expect(subject.balance).to eq(0)
  end

  it "should respond to top_up method" do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it "responds to deduct method" do
    expect(subject).to respond_to(:deduct).with(1).argument
  end

  it "responds to in_journey method" do
    expect(subject).to respond_to(:in_journey)
  end

  it "responds to touch_in method" do
    expect(subject).to respond_to(:touch_in)
  end

  it "responds to touch_out method" do
    expect(subject).to respond_to(:touch_out)
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

  it "should deduct money from my card" do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    oystercard.deduct(5)
    expect(oystercard.balance).to eq(5)
  end

  it "should update in_journey to true after a touch in" do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    oystercard.touch_in
    expect(oystercard.in_journey).to be true
  end

  it "should raise an error if there isn't enough balance" do
    oystercard = Oystercard.new
    expect { oystercard.touch_in }.to raise_error "Not enough funds"
  end

  it "should update in_journey to false after a touch out" do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    oystercard.touch_in
    oystercard.touch_out
    expect(oystercard.in_journey).to be false
  end
end
