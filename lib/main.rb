require "google-10000-english-no-swears.txt"

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

  def pick_word
    words = File.read("google-10000-english-no-swears.txt").split
    word = (words.sample { |word| (5..12).cover?(word.size) }).chars
  end

  def display
    puts "Rounds left: #{rounds}\n" +
      "Wrong characters: #{wrongs.join(" ")}\n" +
      "#{chars.join(" ")}\n" +
      "Type in a character and press Enter to guess\n" +
      "Type 'save' and press Enter to save the game and quit\n" +
      "Type 'exit' and press Enter to quit the game"
  end

  def finish
    if player_wins = true
      display
      puts "You win!"
    else
      display
      puts "You lose!\n" +
        "The word is #{word.join}"
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
    player_wins = false
    rounds = 7
    word = pick_word
    chars = Array.new(word.size, "_")
    wrongs = []

    loop do
      display
      choice = gets.chomp.downcase
      if choice == "save" 
        save_game
      elsif choice == "exit"
        exit
      elsif choice == wrongs.include?
        puts "You've already picked '#{choice}! Try again."
        break
      elsif choice != ("a".."z") 
        puts "Invalid guess. Try again."
        break
      else
        if choice != word.include?
          wrongs << choice
        else 
          word.each_with_index { |char, index|
          if char == choice
            chars[index].sub("_", choice) 
          end
        }
        end
      end
      rounds -= 1
      
      if chars == word
        player_wins = true
        finish
      elsif rounds == 0
        finish
      end
    end
  end
end