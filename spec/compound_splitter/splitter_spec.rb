require "spec_helper"

describe CompoundSplitter::Splitter do
  subject { CompoundSplitter::Splitter.new }

  describe "initialiation" do
    it "should have a default dictionary location" do
      subject.dictionary_location.should == '/usr/share/dict/words'
    end
  end

  describe "dictionary_words" do
    let(:dict) { File.expand_path('spec/fixtures/dictionary1.txt') }
    subject { CompoundSplitter::Splitter.new(dict) }

    it "should return an array of downcased words" do
      expected = %w[rainy day help need]
      subject.dictionary_words.should == expected
    end

    it "should memoize" do
      File.should_receive(:read).with(dict) { dict }
      subject.dictionary_words
      subject.dictionary_words
    end
  end

  describe "max_word_length" do
    let(:dict) { File.expand_path('spec/fixtures/dictionary1.txt') }
    subject { CompoundSplitter::Splitter.new(dict) }

    it "should return the length of the longest word in the dictionary" do
      subject.max_word_length.should == 5
    end

    it "should memoize"
  end

  describe "total_word_count" do
    let(:dict) { File.expand_path('spec/fixtures/dictionary1.txt') }
    subject { CompoundSplitter::Splitter.new(dict) }

    it "should return the total number of words in the dictionary" do
      subject.total_word_count.should == 4
    end

    it "should memoize"
  end

  describe "viterbi_split" do
    it "should return wicked rainy day for rainyday" do
      subject.viterbi_split('rainyday').should == %w[rainy day]
    end
  end

  describe "word_prob" do
    it "should return the probability of a word being real"
  end

  describe "dictionary" do
    it "should return a hash"
    it "should have words as keys"
    it "should have word ocurrance counts as values"
    it "should memoize"
  end
end
