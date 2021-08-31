class Oystercard

  attr_reader :balance, :in_journey

  MAX_LIMIT = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Card's limit is #{MAX_LIMIT}" if above_limit?(amount)
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def above_limit?(amount)
    @balance + amount > MAX_LIMIT
  end
end
