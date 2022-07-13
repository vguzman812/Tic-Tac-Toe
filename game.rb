# frozen_string_literal: true

require_relative "display.rb"

# Contains the logic to play the game
class Game
  include Display
  attr_reader :first_player, :second_player, :board, :current_player

  def initialize
    @board = Board.new
    @first_player = nil
    @second_player = nil
    @current_player = nil
    @opponent = nil
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
    symbol = ""
    if number == 1
      symbol = "X"
      puts "#{name}'s symbol is #{symbol}."
    elsif number == 2
      symbol = "O"
      puts "#{name}'s symbol is #{symbol}."
    end
    Player.new(name, symbol)
  end

  def turn(player)
    cell = turn_input(player)
    board.update_board(cell - 1, player.symbol)
    board.show
  end

  private

  def game_set_up
    puts display_intro
    input = gets.chomp.to_i
    if input == 1
      @first_player = create_player(1)
      @second_player = create_player(2)
    elsif input == 2
      @first_player = create_player(1)
      @second_player = Player.new("Computer", "O")
    else
      puts display_input_warning
      game_set_up
    end
  end

  def player_turns
    @current_player = first_player
    until board.full?
      turn(current_player)
      break if board.game_over?

      @current_player = switch_current_player
    end
  end

  def turn_input(player)
    if player.name == "Computer"
      number = random_position()

      if board.valid_move?(number)
        puts display_computer_turn(number)
        return number
      end
    else
      puts display_player_turn(player.name, player.symbol)
      number = gets.chomp.to_i
      return number if board.valid_move?(number)
      puts display_input_warning
    end
    turn_input(player)
  end

  def random_position
    random_number = rand(1..9)
    random_number
  end

  def switch_current_player
    if @current_player == @first_player
      @second_player
    else
      @first_player
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
