require './lib/oystercard'
require './lib/station'

oc = Oystercard.new
oc.top_up(20)

j = Journey.new("Aldgate")
