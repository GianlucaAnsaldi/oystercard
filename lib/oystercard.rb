class Oystercard

  attr_reader :balance, :in_journey

  MAX_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Card's limit is #{MAX_LIMIT}" if above_limit?(amount)
    @balance += amount
  end

  def touch_in
    fail "Not enough funds" if insufficient_funds?
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
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
