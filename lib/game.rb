require_relative 'file_utilities'

class Game
  include FileUtilities

  def initialize(words_file_path)
    @valid_words = load_valid_words(words_file_path)
    @guesses_left = 7
  end

  private

  def lower_guesses_left
    @guesses_left -= 1
  end

end