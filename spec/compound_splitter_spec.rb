require "spec_helper"

describe CompoundSplitter do
  it "should delegate to splitter" do
    compound = 'wickedweather'
    CompoundSplitter::Splitter.should_receive(:viterbi_split)
      .with(compound)
    CompoundSplitter.split(compound)
  end
end
