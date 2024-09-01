module FileUtilities
  def load_valid_words(path, min_length = 5, max_length = 12)
    valid_words = File.readlines(path).reduce(Array.new()) do |acc, word|
      acc.push(word.chomp) if word.chomp.length.between?(5, 12)
      acc
    end
  end
end