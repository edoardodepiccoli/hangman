require_relative 'file_utilities'

class Game
  include FileUtilities

  def initialize(words_file_path)
    @valid_words = load_valid_words(words_file_path)
    @secret_word = @valid_words.sample
    @guesses_left = 7

    @guessed_letters = []

    play_round
  end

  private

  def play_round
    reset_screen
  end

  def reset_screen
    system('clear')
    puts("guesses left => #{@guesses_left}")
    puts('choose a letter or try to guess the entire word')
    puts
    puts(@secret_word)
    display_secret_word
  end

  def lower_guesses_left
    @guesses_left -= 1
  end

  def display_secret_word
    string = ''
    @secret_word.split('').each do |letter|
      if @guessed_letters.include?(letter)
        string += letter
      else
        string += '-'
      end
    end
    puts(string)
  end

end