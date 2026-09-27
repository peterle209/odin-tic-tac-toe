# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/player'

describe Board do
  describe '#fill_slot' do
    subject(:board) { described_class.new }

    let(:player) { instance_double(Player, letter: 'X') }

    context 'when given valid arguments' do
      it 'fills the slot' do
        expect { board.fill(1, 1, player) }.to change { board.instance_variable_get(:@board).dig(1, 1) }.to('X')
      end
    end
  end

  describe '#clear' do
    subject(:board) { described_class.new }

    let(:player) { instance_double(Player, letter: 'X') }
    let(:empty_board) { described_class.new }

    context 'when clearing a non-empty board' do
      it 'clears the board' do
        board.fill(1, 1, player)
        expect { board.clear }.to change {
          board.instance_variable_get(:@board)
        }.to eql(empty_board.instance_variable_get(:@board))
      end
    end
  end

  describe '#check_win' do
    subject(:board) { described_class.new }

    let(:player) { instance_double(Player, letter: 'X') }

    context 'when a win exists on a row' do
      it 'declares a win on row 1' do
        board.fill(0, 0, player)
        board.fill(0, 1, player)
        board.fill(0, 2, player)
        expect(board.check_win).to be true
      end

      it 'declares a win on row 2' do
        board.fill(1, 0, player)
        board.fill(1, 1, player)
        board.fill(1, 2, player)
        expect(board.check_win).to be true
      end

      it 'declares a win on row 3' do
        board.fill(2, 0, player)
        board.fill(2, 1, player)
        board.fill(2, 2, player)
        expect(board.check_win).to be true
      end
    end

    context 'when a win exists on a column' do
      it 'declares a win on column 1' do
        board.fill(0, 0, player)
        board.fill(1, 0, player)
        board.fill(2, 0, player)
        expect(board.check_win).to be true
      end

      it 'declares a win on column 2' do
        board.fill(0, 1, player)
        board.fill(1, 1, player)
        board.fill(2, 1, player)
        expect(board.check_win).to be true
      end

      it 'declares a win on column 3' do
        board.fill(0, 2, player)
        board.fill(1, 2, player)
        board.fill(2, 2, player)
        expect(board.check_win).to be true
      end
    end

    context 'when a win exists on a diagonal' do
      it 'declares a win on the first diagonal' do
        board.fill(0, 0, player)
        board.fill(1, 1, player)
        board.fill(2, 2, player)
        expect(board.check_win).to be true
      end

      it 'declares a win on the second diagonal' do
        board.fill(0, 2, player)
        board.fill(1, 1, player)
        board.fill(2, 0, player)
        expect(board.check_win).to be true
      end
    end
  end
end
