
# Game need two players
class Player
    attr_reader :name, :symbol
  
    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end
end

=begin

    class HumanPlayer < Player
      def turn_input(player)
        puts display_player_turn(player.name, player.symbol)
        number = gets.chomp.to_i
        return number if board.valid_move?(number)

        puts display_input_warning
        turn_input(player)
  end

      
    end
    
    class ComputerPlayer < Player
    
        
        def group_positions_by_markers(line)
            markers = line.group_by {|position| @game.board[position]}
            markers.default = []
            markers
        end
        
        def select_position!
            opponent_marker = @game.opponent.marker
            
            winning_or_blocking_position = look_for_winning_or_blocking_position(opponent_marker)
            return winning_or_blocking_position if winning_or_blocking_position
            
            if corner_trap_defense_needed?
                return corner_trap_defense_position(opponent_marker)
            end
            
            # could make this smarter by sometimes doing corner trap offense
            
            return random_prioritized_position
        end
        
        def look_for_winning_or_blocking_position(opponent_marker)
            for line in LINES
                markers = group_positions_by_markers(line)
                next if markers[nil].length != 1
                if markers[self.marker].length == 2
                    log_debug "winning on line #{line.join}"
                    return markers[nil].first
                elsif markers[opponent_marker].length == 2
                    log_debug "could block on line #{line.join}"
                    blocking_position = markers[nil].first
                end
            end
            if blocking_position
                log_debug "blocking at #{blocking_position}"
                return blocking_position
            end
        end
        
        def corner_trap_defense_needed?
            corner_positions = [1, 3, 7, 9]
            opponent_chose_a_corner = corner_positions.any?{|pos| @game.board[pos] != nil}
            return @game.turn_num == 2 && opponent_chose_a_corner
        end
        
        def corner_trap_defense_position(opponent_marker)
            # if you respond in the center or the opposite corner, the opponent can force you to lose
            log_debug "defending against corner start by playing adjacent"
            # playing in an adjacent corner could also be safe, but would require more logic later on
            opponent_position = @game.board.find_index {|marker| marker == opponent_marker}
            safe_responses = {1=>[2,4], 3=>[2,6], 7=>[4,8], 9=>[6,8]}
            return safe_responses[opponent_position].sample
        end
        
        def random_prioritized_position
            log_debug "picking random position, favoring center and then corners"
            ([5] + [1,3,7,9].shuffle + [2,4,6,8].shuffle).find do |pos|
                @game.free_positions.include?(pos)
            end
        end
        
        def log_debug(message)
            puts "#{self}: #{message}" if DEBUG
        end
        
        def to_s
            "Computer#{@game.current_player_id}"
        end
    end
=end
  