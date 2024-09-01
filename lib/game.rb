require_relative 'file_utilities'
require 'colorize'
require 'json'
require 'time'

class Game
  include FileUtilities

  def initialize(words_file_path, should_load_saved_game)
    @valid_words = load_valid_words(words_file_path)

    if should_load_saved_game
      saved_string = File.read("lib/saves/saved_game.json")
      saved_data = JSON.parse(saved_string)

      @secret_word = saved_data["secret_word"]
      @guesses_left = saved_data["guesses_left"]

      @guessed_letters = saved_data["guessed_letters"]
      @wrong_guesses = saved_data["wrong_guesses"]
    else
      @secret_word = @valid_words.sample
      @guesses_left = 7

      @guessed_letters = []
      @wrong_guesses = []
    end

    @finished = false

    play_round
  end

  private

  def play_round
    unless @finished
      reset_screen
      user_guess = get_user_guess
      handle_user_guess(user_guess)

      decrease_guesses_left
      check_for_win

      play_round
    end
  end

  def save_game
    json_save = JSON.dump({
      "secret_word" => @secret_word,
      "guesses_left" => @guesses_left,
      "guessed_letters" => @guessed_letters,
      "wrong_guesses" => @wrong_guesses,
      "finished" => @finished
    })
    file = File.new("lib/saves/saved_game.json", "w")
    file.truncate(0)
    file.puts(json_save)
    file.close
  end

  def delete_saved_game
    File.delete('lib/saves/saved_game.json') if File.exist?('lib/saves/saved_game.json')
  end

  def check_for_win
    if @guessed_letters.include?(@secret_word) || @secret_word.split('').all? { |letter| @guessed_letters.include?(letter) }
      @finished = true
      puts('you won!'.colorize(:green))
      delete_saved_game
    elsif @guesses_left == 0
      @finished = true
      puts('you lost :('.colorize(:red))
      delete_saved_game
    end
  end

  def handle_user_guess(user_guess)
    if user_guess == 'exit_game'
      # serialize then finish game
      save_game
      puts('exiting game...')
      @finished = true
    end

    if @secret_word.split('').include?(user_guess) || @secret_word == user_guess
      @guessed_letters.push(user_guess) unless @guessed_letters.include?(user_guess)
    else
      @wrong_guesses.push(user_guess)
    end
  end

  def get_user_guess
    puts('choose a letter or try to guess the entire word')
    user_guess = gets.chomp.downcase
    while user_guess == '' || @guessed_letters.include?(user_guess)
      puts('please try again')
      user_guess = gets.chomp.downcase
    end
    user_guess
  end

  def reset_screen
    system('clear')
    puts('type "exit_game" any time to save the game and exit it')
    puts
    puts("guesses left => #{@guesses_left}")
    puts("wrong guessed words and letters => #{@wrong_guesses}")
    puts
    puts(@secret_word)
    display_secret_word
    puts
  end

  def decrease_guesses_left
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