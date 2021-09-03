class Oystercard

  attr_reader :balance, :journeys

  MAX_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @journeys = []
  end

  def top_up(amount)
    fail "Card's limit is #{MAX_LIMIT}" if above_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Not enough funds" if insufficient_funds?
    @journeys << { entry_station: station, exit_station: nil}
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journeys[@journeys.length - 1][:exit_station] = station
  end

  def in_journey?
    @journeys[@journeys.length - 1][:exit_station].nil?
  end
  private

  def deduct(fare)
    @balance -= fare
  end

  def above_limit?(amount)
    @balance + amount > MAX_LIMIT
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end  
end
