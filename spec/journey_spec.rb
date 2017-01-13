require 'journey'

describe Journey do
  subject(:journey){described_class.new("Aldgate")}

  it 'responds to a new journey class' do
    expect(journey).to be_an_instance_of Journey
  end
  context "when starting a journey" do
    it 'initializes with @entry_station' do
      expect(journey.entry_station).not_to be_nil
    end
  end
  describe "#finish" do
    context "When finishing a Journey" do
      before do
        journey.finish("Aldgate East")
      end
      it "Saves the exit_station" do
        expect(journey.exit_station).not_to be_nil
      end
    end
  end
  describe "#complete?" do
    context "when Journey is not complete" do
      it "returns false" do
        expect(journey.complete?).to eq false
      end
    end
    context"when journey is complete" do
      before do
        journey.finish("Aldgate East")
      end
      it "returns true" do
        expect(journey.complete?).to eq true
      end
    end
  end
  describe "#fare" do
    it "responds to the fare method" do
      expect(journey).to respond_to(:fare)
    end
    context "when we have both entry and exit stations" do
      it "returns the minimum fare" do
        journey.finish("Aldgate East")
        expect(journey.fare).to eq Journey::MIN_FARE
      end
    end
    context "when we dont have an entry_station" do
      it "returns the penalty fare" do
        expect(journey.fare).to eq Journey::PENALTY_FARE
      end
    end
  end
end
