require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/game'

def get_player_name(player_number)
  puts 'Please enter your name:'
  name = gets.chomp
  if name.empty?
    puts 'Please enter a non-empty string'
    name = gets.chomp
  end
  puts "Player #{player_number}: #{name}"
  name
end

def start_game
  player_one_name = get_player_name(1)
  player_two_name = get_player_name(2)

  Game.new(player_one_name, player_two_name)
end

game = start_game

while game.play_round
end

puts 'Thanks for playing!'
