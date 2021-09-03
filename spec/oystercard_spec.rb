require 'oystercard'

describe Oystercard do

  let(:entry_station) { double :station}
  let(:exit_station) { double :station}
  let(:journey) { { entry_station: entry_station, exit_station: exit_station } }

  it "responds to balance method" do 
    expect(subject).to respond_to(:balance)
  end

  it "should have an initial balance of 0" do
    expect(subject.balance).to eq(0)
  end

  it "should respond to top_up method" do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it "responds to in_journey method" do
    expect(subject).to respond_to(:in_journey?)
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

  it "should update in_journey to true after a touch in" do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    oystercard.touch_in(entry_station)
    expect(oystercard.in_journey?).to be true
  end

  it "should raise an error if there isn't enough balance" do
    oystercard = Oystercard.new
    expect { oystercard.touch_in(entry_station) }.to raise_error "Not enough funds"
  end

  it "should update in_journey to false after a touch out" do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.in_journey?).to be false
  end

  it "should charge the fare after touch_out" do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    oystercard.touch_in(entry_station)
    expect { oystercard.touch_out(exit_station) }.to change{oystercard.balance}.by(-Oystercard::MINIMUM_FARE)
  end

  it "stores the entry station" do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    oystercard.touch_in(entry_station)
    expect(oystercard.journeys[0][:entry_station]).to eq(entry_station)
  end

  it "stores the exit station" do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.journeys[0][:exit_station]).to eq(exit_station)
  end

  it "has an empty history of travels when created" do
    oystercard = Oystercard.new
    expect(oystercard.journeys).to be_empty
  end

  it "stores a journey" do
    oystercard =Oystercard.new
    oystercard.top_up(10)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.journeys).to include(journey)
  end
end
