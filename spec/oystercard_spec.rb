require 'oystercard'
require 'journey'

describe Oystercard do
  subject(:card) { described_class.new}
  let(:station) {double :station}
  let(:station2) {double :station}
  top_up_fund = 20
  min_fare = 1
  it 'initialises with a balance of 0' do
    expect(card.balance).to eq 0
  end

  it 'initialises with an empty journey history' do
    expect(card.journey_history).to eq []
  end

describe '#top_up' do
  it 'tops up by a given amount' do
    expect(card.top_up(10)).to eq card.balance
  end

  it 'throws error if balance exceeds 90' do
    expect{ card.top_up(91) }.to raise_error("Balance cannot exceed #{Oystercard::MAX_BALANCE}")
  end
end

  describe '#touch_in' do
    it 'checks that the card responds to the touch_in method' do
      expect(card).to respond_to(:touch_in)
  end

  it 'raises an error if insufficient balance on card' do
    expect{card.touch_in(station)}.to raise_error("Insufficient funds on card. Top up!")
  end

  it 'creates a new journey object' do
    card.top_up(top_up_fund)
    card.touch_in(station)
    expect(card.journey).not_to be_nil
  end

end

  describe '#touch_out' do
    it 'checks that the card responds to the touch_out method' do
      expect(card).to respond_to(:touch_out)
    end

    it 'pushes a hash to our journey history' do
      card.top_up(top_up_fund)
      card.touch_in(station)
      card.touch_out(station2)
      expect(card.journey_history).to include({entry_station: station, exit_station: station2})
  end

    it 'deducts the MIN_FARE when we touch out' do
      card.top_up(top_up_fund)
      card.touch_in(station)
      expect{card.touch_out(station2)}.to change{card.balance}.by(-min_fare)
    end

    it 'forgets the entry station when touching out' do
      card.top_up(top_up_fund)
      card.touch_in(station)
      card.touch_out(station2)
      expect(card.journey).to eq nil
    end
end

  describe '#journey_history' do
    it 'stores a journey history' do
    card.top_up(top_up_fund)
    card.touch_in(station)
    card.touch_out(station2)
    expect((card.journey_history).length).to eq(1)
  end
end
end
