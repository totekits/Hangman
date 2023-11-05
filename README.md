# Hangman
[This project](https://www.theodinproject.com/lessons/ruby-hangman) is from the Odin Project's Ruby curriculum.
It's a command line Hangman game where one player plays agaist the computer with options to save and load the game. 
## Steps
1. Create Hangman class to host the game
2. Define game method to be the main method of the game.
3. Inside the game method, define main_menu method. When starting the game and when the game ends, user can choose to play a new game, load or exit the game.
4. Define initilize method with variables: @winner = false, @guesses = 7, and four empty arrays of @keyword, @clur, @right_letters, @wrong_letters. 
5. Define display_main_manu method to display the main menu. 
6. Define process_main_menu method to process the user's choice. 
7. Define new_game method to start a new game with variables. 
8. Define play method to loop the game until @winner = true. 
9. Define display_game_state to display the game state. 
10. Define display_game_menu method. When user is playing the game, they can choose to start a new game, save, load a saved game or exit the game.
11. Define process_game_menu method to process user's choice. 
12. Define check_win method to check if the game is finished and if so, reveal the keyword and declare winner or loser. 
13. Require 'json' for the save and load game feature. 
14. Define save_game method to save a game. 
15. Define load_game method to load a saved game. 
16. Define load_saved_game method to load a saved game. 
## Things I learned
- Range#cover?
- Regexp class
- Dir class: Dir.makdir, Dir.exist?, Dir.empty?, Dir.children, Dir.entries
- File class: File.write
- JSON.dump, JSON.parse
- choice = gets.chomp #=> command, number = choice.split