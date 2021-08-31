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

end




#In order to use public transport
#As a customer
#I want money on my card