require "spec_helper"

describe CompoundSplitter::Splitter do
  subject { CompoundSplitter::Splitter.new }

  describe "split" do
    it "should return rainy day for rainyday" do
      subject.split('rainyday').should == %w[rainy day]
    end

    it "should return w for w" do
      subject.split('w').should == %w[w]
    end

    it "should return pen island for penisland" do
      subject.split('penisland').should == %w[penis land]
    end

    it "should do something with ''" do
      subject.split('').should == []
    end
  end
end
