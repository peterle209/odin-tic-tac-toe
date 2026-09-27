# frozen_string_literal: true

class Game
  XSYMBOL = ' X '
  OSYMBOL = ' O '
  BOARDMAX = 9
  attr_reader :current_turn, :player_one, :player_two

  def initialize(player_one_name, player_two_name)
    @board = Board.new
    @player_one = Player.new(player_one_name, XSYMBOL)
    @player_two = Player.new(player_two_name, OSYMBOL)
    @turn = 1
  end

  def play_round
    print_game_status
    until check_win || check_tie
      advance_turn
      update_board
      print_game_status
    end
    if check_tie
      handle_tie
    else
      handle_win
    end
    puts 'Play again? (y/n)'
    return false if gets.chomp == 'n'

    game_reset
    true
  end

  private

  def game_reset
    @board.clear
    @current_turn = @player_one
    @turn = 1
    print_game_status
  end

  def print_standings
    puts 'Current Standings:'
    puts "#{@player_one.name}: #{@player_one.score} wins"
    puts "#{@player_two.name}: #{@player_two.score} wins"
  end

  def handle_win
    winner = @current_turn
    puts "#{winner.name} wins!"
    winner.update_score
    print_standings
  end

  def handle_tie
    puts 'It was a tie!'
    print_standings
  end

  def check_win
    @board.check_win
  end

  def check_tie
    @turn > BOARDMAX
  end

  def reset_board
    @board.clear
  end

  def print_game_status
    puts "Turn ##{@turn}: #{@player_one.name}"
    @board.current_board
  end

  def advance_turn
    @current_turn = if @current_turn == @player_one
                      @player_two
                    else
                      @player_one
                    end
    @turn += 1
    @current_turn
  end

  def integer?(input)
    !Integer(input, exception: false).nil?
  end

  def player_input
    puts "what row and column would you like to place your symbol (current symbol: #{@current_turn.letter}) (eg. '1,2' for row 1 column 2)"
    player_input = gets.chomp.split(',')
    until check_slot(player_input)
      puts 'Please re-enter a valid and empty slot!'
      player_input = gets.chomp.split(',')
    end
    player_input
  end

  def update_board
    print "#{current_turn.name}, "
    curr_player_input = player_input
    @board.fill(curr_player_input[0], curr_player_input[1], @current_turn)
  end

  def check_slot(player_input)
    return false unless player_input.size == 2

    player_input.each { |entry| return false unless integer?(entry) }
    player_input.map! { |entry| entry.to_i - 1 } # subtract 1 to account for 0 indexing
    row = player_input[0]
    column = player_input[1]
    return true if @board.empty_slot?(row, column)

    false
  end
end
