class Oystercard

  attr_reader :balance

  MAX_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Card's limit is #{MAX_LIMIT} pounds" if above_limit?(amount)
    @balance += amount
  end

  private

  def above_limit?(amount)
    @balance + amount > MAX_LIMIT
  end
end
