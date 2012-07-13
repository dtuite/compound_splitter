require "spec_helper"

describe CompoundSplitter::Splitter do
  subject { CompoundSplitter::Splitter.new }

  describe "viterbi_split" do
    it "should return rainy day for rainyday" do
      subject.viterbi_split('rainyday').should == %w[rainy day]
    end

    it "should return w for w" do
      subject.viterbi_split('w').should == %w[w]
    end

    it "should return pen island for penisland" do
      subject.viterbi_split('penisland').should == %w[penis land]
    end

    it "should do something with ''" do
      subject.viterbi_split('').should == []
    end
  end
end
