module CompoundSplitter
  class Dictionary
    attr_accessor :file_location

    def initialize(file_location = nil)
      @file_location = file_location || '/usr/share/dict/words'
    end

    # Read a file of newline separated words into a downcased array.
    def words
      unless @words
        f = File.read(file_location)
        @words = []
        f.each_line { |l| @words << l.chomp.downcase }
      end
      @words
    end

    # Assign the length of the longest word in the dictionary.
    def max_word_length
      @max_word_length ||= words.max.length
    end

    # Assign the total number of words in the dictionary. It's a float
    # because we're going to divide by it later on.
    def total_word_count
      @total_word_count ||= words.length.to_f
    end

    def ocurrances_hash
      @ocurrances_hash ||= self.class.count_dupes(words.sort)
    end

    def [](lookup_word)
      ocurrances_hash[lookup_word]
    end

    # Get the probability of a specific word ocurring in the dictionary.
    def word_prob(word)
      # Return the number of ocurrances of a word in the dictionary or 0
      count = self[word] || 0
      # Divide by the total number of words.
      count / total_word_count
    end

  private

    # Turn an array of words into a hash where each word has a key
    # and each value is the number of ocurrances of the key in the array.
    # INFO: http://stackoverflow.com/a/5470797/574190
    def self.count_dupes(words_array)
      words_array.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
    end
  end
end
