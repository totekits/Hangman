require "json"

class Hangman

  def initialize
    @winner = false
    @guesses = 7
    @keyword = []
    @clue = []
    @right_letters = []
    @wrong_letters = []
  end

  def game
    main_menu
  end

  private

  def save_game
    Dir.mkdir("saved_games") unless Dir.exist?("saved_games")
    File.write("saved_games/#{@clue.join}.json", JSON.dump(current_game_state))
    puts "Your game is saved as '#{@clue.join}'\n" +
      "see you next time!"
    exit
  end

  def load_saved_game(file)
    saved_game = JSON.parse(File.read("saved_games/#{file}"))
  
    @winner = saved_game["winner"]
    @guesses = saved_game["guesses"]
    @keyword = saved_game["keyword"]
    @clue = saved_game["clue"]
    @right_letters = saved_game["right_letters"]
    @wrong_letters = saved_game["wrong_letters"]
  
    play
  end

  def load_game
    loop do
      if !Dir.exist?("saved_games") || Dir.empty?("saved_games")
        puts "No saved games found."
        greet
      else
        saved_games = Dir.children("saved_games")
 
        puts "Enter a command:\n" +
          "'{number of saved game}' to load the game\n" +
          "'del {number of saved game}' to delete the game\n" +
          "'main' to go back to the main menu"

        saved_games.each_with_index do |file, index|
          puts "#{index + 1} #{file}"
        end

        choice = gets.chomp
        command, number = choice.split

        if command.downcase == 'del' && number.to_i.between?(1, saved_games.size)
          file_to_delete = saved_games[number.to_i - 1]
          File.delete("saved_games/#{file_to_delete}")
          puts "Game '#{file_to_delete}' deleted successfully."
        elsif number.to_i.between?(1, saved_games.size)
          load_saved_game(saved_games[number.to_i - 1])
        elsif
          command.downcase == 'main'
          greet
        else
          puts "Invalid input. Try again."
        end
      end
    end
  end

  def current_game_state
    {
    winner: @winner,
    guesses: @guesses,  
    keyword: @keyword,
    clue: @clue,
    right_letters: @right_letters,
    wrong_letters: @wrong_letters
    }
  end

  def display_main_menu
    puts "Enter a command:\n" +
      "'new'\tto start a new game\n" +
      "'load'\tto load a saved game\n" +
      "'exit'\tto exit the game"
  end

  def pick_random_word
    dictionary = File.readlines("google-10000-english-no-swears.txt").map(&:chomp)
    dictionary.select { |word| (5..12).cover?(word.size) }.sample.chars
  end

  def new_game
    puts "You must guess the keyword.\n" +
      "You lose if you pick the wrong letters 7 times.\n" +
      "Good luck!"

    @winner = false
    @guesses = 7
    @keyword = pick_random_word
    @clue = Array.new(@keyword.size, "_")
    @right_letters = []
    @wrong_letters = []

    play
  end

  def process_main_menu(choice)
    case choice
    when "new"
      new_game
    when "load"
      load_game
    when "exit"
      exit
    else
      puts "Invalid command. Try again."
    end
  end

  def main_menu
    if @winner == false
      puts "Welcome to Hangman!"
    elsif @winner == true
      puts "Thanks for playing Hangman!"  
    end

    loop do  
      display_main_menu
      choice = gets.chomp.downcase
      process_main_menu(choice)
    end
  end

  def display_game_state
    puts "Guesses left: #{@guesses}\n" +
      "Wrong letters: #{@wrong_letters.join(" ")}\n" +
      "#{@clue.join(" ")}\n"
  end

  def display_game_menu
    puts "Enter a letter [a-z] to guess, or a command:\n" + 
      "'new'\tto start a new game\n" +
      "'save\tto save the game and exit\n" +
      "'load'\tto load a saved game\n" +
      "'exit'\tto exit the game"
  end

  def process_game_menu(choice)
    case choice
    when "new"
      new_game
    when "save"
      save_game
    when "load"
      load_game
    when "exit"
      exit
    else
      return choice
    end
  end

  def process_guess(choice)
    if !choice.match?(/^[a-z]$/)
      puts "Invalid command. Try again."
    elsif @wrong_letters.include?(choice) || @right_letters.include?(choice)
      puts "You've already picked '#{choice}! Try again."
    else 
      if @keyword.include?(choice)
        @keyword.each_with_index do |char, index|
          if char == choice
            @clue[index] = choice 
          end
        end
        @right_letters << choice
      else 
        @wrong_letters << choice
        @guesses -= 1
      end
    end  
  end

  def check_win
    if @clue.join == @keyword.join
      puts "You win!\n" +
        "The keyword is '#{@keyword.join}'"
      @winner = true
    elsif @guesses == 0
      puts "You lose!\n" +
        "The keyword is '#{@keyword.join}'"
      @winner = true
    end
  end

  def play
    loop do
      display_game_state
      display_game_menu
      choice = gets.chomp.downcase
      process_game_menu(choice)
      process_guess(choice)
      check_win
      main_menu if @winner
    end
  end  
end

Hangman.new.game