require "spec_helper"

describe CompoundSplitter::Dictionary do
  let(:dict) { File.expand_path('spec/fixtures/dictionary1.txt') }
  subject { CompoundSplitter::Dictionary.new(dict) }


  describe "initialiation" do
    subject { CompoundSplitter::Dictionary.new }

    it "should have a default dictionary file location" do
      subject.file_location.should == '/usr/share/dict/words'
    end
  end

  describe "words" do
    it "should return an array of downcased words" do
      expected = %w[rainy day help need help]
      subject.words.should == expected
    end

    it "should memoize" do
      File.should_receive(:read).with(dict) { dict }
      subject.words
      subject.words
    end
  end

  describe "max_word_length" do
    it "should return the length of the longest word in the dictionary" do
      subject.max_word_length.should == 5
    end

    it "should memoize"
  end

  describe "total_word_count" do
    it "should return the total number of words in the dictionary" do
      subject.total_word_count.should == 5.0
    end
  end

  describe "word_prob" do
    it "should return the probability of a word being real" do
      subject.word_prob('help').should == 0.4
    end

    it "should return 0 for non-existant words" do
      subject.word_prob('grinnick').should == 0
    end
  end

  describe "ocurrances_hash" do
    it "should return a hash" do
      subject.ocurrances_hash.should be_instance_of(Hash)
    end

    it "should have words as keys" do
      subject.ocurrances_hash.keys.should include('help')
    end

    it "should have word ocurrance counts as values" do
      subject.ocurrances_hash['help'].should == 2
    end

    it "should memoize"
  end

  describe "[]" do
    it "should lookup words in the ocurrances_hash" do
      word = "help"
      subject.ocurrances_hash.should_receive(:[]).with(word)
      subject[word]
    end
  end
end
