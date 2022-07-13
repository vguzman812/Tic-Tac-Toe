module Display
  def display_intro
    "Let's play a simple Tic-Tac-Toe game in the console! \n\n
      Would you like to play with a friend or a computer? (1 for a friend, 2 for a computer)"
  end

  def display_name_prompt(number)
    "What is the name of player ##{number}?"
  end

  def display_input_warning
    "\e[31mSorry, that is an invalid answer. Please, try again.\e[0m"
  end

  def display_player_turn(name, symbol)
    "#{name}, please enter a number (1-9) that is available to place an '#{symbol}'."
  end

  def display_computer_turn(number)
    "The Computer has chosen the number '#{number}' to place an 'O'."
  end

  def display_winner(player)
    "GAME OVER! #{player} is the winner!"
  end

  def display_tie
    "It's a draw."
  end
end
