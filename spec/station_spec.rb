require "station"

describe Station do

  subject { described_class.new("Stratford", 2) }

  it { is_expected.to be_instance_of Station }

  it "has a name" do
    expect(subject.name).to eq "Stratford"
  end

  it "has a zone" do
    expect(subject.zone).to eq 2
  end
end