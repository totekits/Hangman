class Hangman
  def play
    greet
    game
    finish
  end

  private

  def greet
    loop do 
      puts "Welcome to Hangman!\n" +
        "You have 7 guesses to guess the keyword\n" +
        "Type in the command and press Enter\n" +
        "'new'\tto start a new game\n" +
        "'load'\tto load a saved game\n" +
        "'exit'\tto exit the game"
        
      choice = gets.chomp.downcase

      if choice == "new"
        break
      elsif choice == "load"
        load_game
      elsif choice == "exit"
        exit
      else
        puts "Invalid command. Try again."
      end
    end
  end

  def pick_random_word
    words = File.readlines("google-10000-english-no-swears.txt").map(&:chomp)
    words.select { |word| (5..12).cover?(word.size) }.sample.chars
  end

  def display(guesses, clues, wrongs)
    puts "Guesses left: #{guesses}\n" +
      "Wrong characters: #{wrongs.join(" ")}\n" +
      "#{clues.join(" ")}\n" +
      "Type in a character and press Enter to guess\n" +
      "Type 'save' and press Enter to save the game and quit\n" +
      "Type 'exit' and press Enter to quit the game"
  end

  def finish(player_wins, keyword)
    if player_wins == true
      puts "You win!"
    else
      puts "You lose!\n" +
        "The keyword is #{keyword.join}"
    end

    loop do
      puts "Type 'new' and press Enter to start a new game\n" +
        "Type 'load' and press Enter to load a saved game\n"
        "Type 'exit' and press Enter to quit the game"

      choice = gets.chomp.downcase
      if choice == "new"
        game
      elsif choice == "load"
        load_game
      elsif choice == "exit"
        exit
      else
        puts "Invalid command. Try again."
      end
    end
  end

  def game
    guesses = 7
    player_wins = false
    keyword = pick_random_word
    clues = []
    (keyword.size).times { clues << "_" }
    rights = []
    wrongs = []

    loop do
      display(guesses, clues, wrongs)
      choice = gets.chomp.downcase
      if choice == "save" 
        save_game
      elsif choice == "exit"
        exit
      elsif wrongs.include?(choice) || rights.include?(choice)
        puts "You've already picked '#{choice}! Try again."
      elsif !choice.match?(/^[a-z]$/)
        puts "Invalid guess. Try again."
      else
        if keyword.include?(choice)
          keyword.each_with_index do |char, index|
            if char == choice
              clues[index] = choice 
            end
          end
          rights << choice
        else 
          wrongs << choice
          guesses -= 1
        end
      end
      
      if clues == keyword
        player_wins = true
        finish(player_wins, keyword)
      elsif guesses == 0
        finish(player_wins, keyword)
      end
    end
  end
end

Hangman.new.play