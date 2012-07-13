module CompoundSplitter
  class Splitter
    attr_accessor :dictionary

    def initialize(dictionary = nil)
      @dictionary = dictionary || Dictionary.new
    end

    def viterbi_split(compound)
      probs, lasts = [1.0], [0]

      1.upto(compound.length) do |i|

        biggest = [0, i - dictionary.max_word_length].max
        iter_array = (biggest..(i - 1)).to_a

        all_probs = []
        iter_array.each do |j|
          part_of_compound = compound[j..(i-1)]
          probability_part_is_word = dictionary.word_prob(part_of_compound)
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

      [words.reverse, probs[-1]]
      # words.reverse
    end

  end
end
