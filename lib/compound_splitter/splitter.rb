module CompoundSplitter
  class Splitter
    attr_accessor :dictionary

    def initialize(dictionary = nil)
      @dictionary = dictionary || Dictionary.new
    end

    def split(compound)
      return [] if compound.empty?

      probs, lasts = [1.0], [0]

      1.upto(compound.length) do |i|

        biggest = [0, i - dictionary.max_word_length].max

        all_probs = []
        biggest.upto(i - 1).each do |j|
          part_of_compound = compound[j..(i-1)]
          probability_part_is_word = dictionary.word_prob(part_of_compound)
          something = [(probs[j] || 0.0) * probability_part_is_word, j]
          all_probs << something
        end

        probs << all_probs.max[0]
        lasts << all_probs.max[1]
      end

      words = []
      i = compound.length
      while 0 < i
        words << compound[lasts[i]..(i-1)]
        i = lasts[i]
      end

      # [words.reverse, probs[-1]]
      words.reverse
    end

  end
end
