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
    greet
  end

  private

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

    @keyword = pick_random_word
    @clue = Array.new(@keyword.size, "_")

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

  def greet
    puts "Welcome to Hangman!"
    display_main_menu

    loop do
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

  def thank
    puts "Thanks for trying my game!"
    display_main_menu

    loop do
      choice = gets.chomp.downcase
      process_main_menu(choice)
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
      break if @winner
    end
    thank
  end  
end

Hangman.new.game