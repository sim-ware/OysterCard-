require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey_history, :journey
  MAX_BALANCE = 90

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amt)
    raise 'Balance cannot exceed 90' if (balance + amt) > MAX_BALANCE
    @balance += amt
  end

  def touch_in(station)
    raise "Insufficient funds on card. Top up!" if balance < Journey::MIN_FARE
    multiple_touch_in unless @journey == nil
    @journey = Journey.new(station)
  end

  def touch_out(station)
    multiple_touch_out(station) if @journey == nil
    @journey.finish(station)
    deduct(@journey.fare)
    catalogue_journey
  end

  private

  def multiple_touch_in
    deduct(@journey.fare)
    catalogue_journey
  end

  def multiple_touch_out(station)
    @journey = Journey.new(station)
    deduct(@journey.fare)
    catalogue_journey
  end

  def catalogue_journey
    @journey_history << { entry_station: @journey.entry_station, exit_station: @journey.exit_station }
    @journey = nil
  end

  def deduct(amt)
    @balance -= amt
  end


end
