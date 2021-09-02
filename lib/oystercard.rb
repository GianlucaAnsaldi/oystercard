class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journeys

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
    @entry_station = station
    # @journeys[:entry_station] = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    @journeys << { entry_station: @entry_station, exit_station: @exit_station }
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
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
