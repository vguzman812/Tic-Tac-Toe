
require_relative 'display.rb'

# Contains the logic to play the game
class Game
  include Display
  attr_reader :first_player, :second_player, :board, :current_player

  def initialize
    @board = Board.new
    @first_player = nil
    @second_player = nil
    @current_player = nil
  end

  def play
    game_set_up
    board.show
    player_turns
    conclusion
  end

  def create_player(number) 
    puts display_name_prompt(number)
    name = gets.chomp
    symbol = ''
        if number == 1
            symbol = 'X'
            puts "#{name}'s symbol is #{symbol}."
        elsif number == 2
            symbol = 'O'
            puts "#{name}'s symbol is #{symbol}."
        end
    Player.new(name, symbol) #HumanPlayer.new(name, symbol)
  end

  def human_turn(player)
    cell = turn_input(player)
    board.update_board(cell - 1, player.symbol)
    board.show
  end

  private

  #recently modified to add ComputerPlayer.new("O") for future implementation
  def game_set_up
    puts display_intro
    if gets.chomp.to_i == 1
      @first_player = create_player(1)
      @second_player = create_player(2)
    elsif gets.chomp.to_i == 2
      @first_player = create_player(1)
      @second_player = ComputerPlayer.new("O")
    else
      puts display_input_warning
    end
  end

  def symbol_input(duplicate)
    player_symbol_prompts(duplicate)
    input = gets.chomp
    return input if input.match?(/^[^0-9]$/) && input != duplicate

    puts display_input_warning
    symbol_input(duplicate)
  end
  
  #Recently modified to differentiate between HumanPlayer and ComputerPlayer
  def player_turns
    @current_player = first_player
    if second_player.class == HumanPlayer
      until board.full?
        human_turn(current_player)
        break if board.game_over?

        @current_player = switch_current_player
      end
    elsif second_player.class == ComputerPlayer
      until board.full?
        
    end
  end

  def turn_input(player) #possibly place this in a human player class
    puts display_player_turn(player.name, player.symbol)
    number = gets.chomp.to_i
    return number if board.valid_move?(number)

    puts display_input_warning
    turn_input(player)
  end

  def switch_current_player
    if current_player == first_player
      second_player
    else
      first_player
    end
  end

  def conclusion
    if board.game_over?
      puts display_winner(current_player.name)
    else
      puts display_tie
    end
  end
end
