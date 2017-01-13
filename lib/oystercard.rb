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
    multiple_touch_in
    @journey = Journey.new(station)
  end

  def touch_out(station)
    multiple_touch_out
    @journey.finish(station)
    catalogue_journey
  end

  private

  def multiple_touch_in
    catalogue_journey if @journey
  end

  def multiple_touch_out
    @journey = Journey.new(nil) if @journey.nil?
  end

  def catalogue_journey
    deduct(@journey.fare)
    @journey_history << @journey
    @journey = nil
  end

  def deduct(amt)
    @balance -= amt
  end


end
