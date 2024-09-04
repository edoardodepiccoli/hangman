require_relative 'lib/game'
system("clear")

should_load_saved_game = false

if File.exist?('lib/saves/saved_game.json')
  puts("welcome to hangman!")
  puts("do you want to load the last saved game or play a new one (y/n)")

  user_choice = gets.chomp.downcase

  while user_choice != 'y' && user_choice != 'n'
    puts('please try again')
    user_choice = gets.chomp.downcase
  end

  should_load_saved_game = user_choice == 'y' ? true : false
end

game = Game.new('lib/words.txt', should_load_saved_game)
