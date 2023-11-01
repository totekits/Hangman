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
        "'n'\tto play a new game\n" +
        "'l'\tto load a saved game\n" +
        "'e'\tto exit the game"
        
      choice = gets.chomp.downcase

      if choice == "n"
        break
      elsif choice == "l"
        load_game
      elsif choice == "e"
        exit
      else
        puts "Invalid command. Try again."
      end
    end
  end
end