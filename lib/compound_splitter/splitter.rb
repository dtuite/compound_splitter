module CompoundSplitter
  class Splitter
    attr_accessor :dictionary_location

    def initialize(dictionary_location = nil)
      @dictionary_location = dictionary_location || '/usr/share/dict/words'
    end

    # Read a file of newline separated words into a downcased array.
    def dictionary_words
      unless @dictionary_words
        f = File.read(dictionary_location)
        @dictionary_words = []
        f.each_line { |l| @dictionary_words << l.chomp.downcase }
      end
      @dictionary_words
    end

    # Get the probability of a specific word ocurring in the
    # dictionary.
    def word_prob(word)
      # Return the number of ocurrances of a word in the dictionary or 0
      count = dictionary[word] || 0
      # Divide by the total number of words.
      count / total_word_count
    end

    # Assign the length of the longest word in the dictionary.
    def max_word_length
      @max_word_length ||= dictionary_words.max.length
    end

    # Assign the total number of words in the dictionary. It's a float
    # because we're going to divide by it later on.
    def total_word_count
      @total_word_count ||= dictionary_words.length.to_f
    end

    def dictionary
      @dictionary ||= self.class.count_dupes(dictionary_words.sort)
    end

    def viterbi_split(compound)
      probs, lasts = [1.0], [0]

      1.upto(compound.length) do |i|

        biggest = [0, i - max_word_length].max
        iter_array = (biggest..(i - 1)).to_a

        all_probs = []
        iter_array.each do |j|
          part_of_compound = compound[j..(i-1)]
          probability_part_is_word = word_prob(part_of_compound)
          something = [(probs[j] || 0.0) * probability_part_is_word, j]
          all_probs << something
        end

        max_all_probs = all_probs.max
        probs << max_all_probs[0]
        lasts << max_all_probs[1]
      end

      words = []
      i = compound.length
      while 0 < i
        word_to_append = compound[lasts[i]..(i-1)]
        words << word_to_append
        i = lasts[i]
      end

      # [words.reverse, probs[-1]]
      words.reverse
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
