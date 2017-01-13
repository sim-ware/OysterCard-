require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey_history, :journey
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amt)
    raise 'Balance cannot exceed 90' if (balance + amt) > MAX_BALANCE
    @balance += amt
  end

  def touch_in(station)
    raise "Insufficient funds on card. Top up!" if balance < MIN_FARE
    @journey = Journey.new(station)
  end

  def touch_out(station)
    @journey.finish(station)
    @journey_history << { entry_station: @journey.entry_station, exit_station: @journey.exit_station }
    deduct(MIN_FARE)
    @journey = nil
  end

  private

  def deduct(amt)
    @balance -= amt
  end


end
