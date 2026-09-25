class Board
  BOARD_SIZE = 3
  EMPTY_SLOT = '[ ]'

  def initialize
    @board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) { EMPTY_SLOT } }
  end

  def fill(row, column, player)
    @board[row][column] = player.letter
  end

  def empty_slot(row, column)
    return true if @board.dig(row, column) == EMPTY_SLOT

    false
  end

  def current_board
    @board.each do |row|
      row.each { |entry| print "#{entry} " }
      puts
    end
  end

  def clear
    @board.map! do |row|
      row.map! { |entry| entry = EMPTY_SLOT }
    end
  end

  def col_win
    col_one = @board[0][0] == @board[1][0] && @board[1][0] == @board[2][0] && @board[0][0] != EMPTY_SLOT
    col_two = @board[0][1] == @board[1][1] && @board[1][1] == @board[2][1] && @board[0][1] != EMPTY_SLOT
    col_three = @board[0][2] == @board[1][2] && @board[1][2] == @board[2][2] && @board[0][2] != EMPTY_SLOT
    puts 'col_one' if col_one
    puts 'col_two' if col_two
    puts 'col_three' if col_three
    col_one || col_two || col_three
  end

  def row_win
    row_one = @board[0][0] == @board[0][1] && @board[0][1] == @board[0][2] && @board[0][0] != EMPTY_SLOT
    row_two = @board[1][0] == @board[1][1] && @board[1][1] == @board[1][2] && @board[1][0] != EMPTY_SLOT
    row_three = @board[2][0] == @board[2][1] && @board[2][1] == @board[2][2] && @board[2][0] != EMPTY_SLOT
    puts 'row_one' if row_one
    puts 'row_two' if row_two
    puts 'row_three' if row_three
    row_one || row_two || row_three
  end

  def diag_win
    diag_one = @board[1][1] != EMPTY_SLOT && @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]
    diag_two = @board[1][1] != EMPTY_SLOT && @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0]
    puts 'diag_one' if diag_one
    puts 'diag_two' if diag_two
    diag_one || diag_two
  end

  def check_win
    col_win || row_win || diag_win
  end
end
