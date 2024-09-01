require_relative 'lib/game'

should_load_saved_game = false

if File.exist?('lib/saves/saved_game.json')
  puts("welcome to hangman!")
  puts("do you want to load the last saved game or play a new one (a/b)")

  user_choice = gets.chomp.downcase

  while user_choice != 'a' && user_choice != 'b'
    puts('please try again')
    user_choice = gets.chomp.downcase
  end

  should_load_saved_game = user_choice == 'a' ? true : false
end

game = Game.new('lib/words.txt', should_load_saved_game)