class Journey
attr_reader :entry_station, :exit_station, :fare
MIN_FARE = 1
PENALTY_FARE = 6

  def initialize(entry_station)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
  end

  def complete?
    !!@exit_station ? true : false
  end

  def fare
    !!@entry_station && !!@exit_station ? @fare = MIN_FARE : @fare = PENALTY_FARE
  end

end
