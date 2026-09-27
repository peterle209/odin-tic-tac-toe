# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  describe '#update_score' do
    player_name = 'player'
    letter = 'X'
    subject(:player) { described_class.new(player_name, letter) }

    context 'when player wins a game' do
      it 'increments the score' do
        expect { player.update_score }.to change { player.score }.by(1)
      end
    end
  end
end
