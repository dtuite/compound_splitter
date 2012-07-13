require "compound_splitter/version"
require "compound_splitter/splitter"
require "compound_splitter/dictionary"

module CompoundSplitter
  def self.split(compound)
    Splitter.split(compound)
  end
end
