# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/player'
puts 'Insert Player 1 Name:'
player_one_name = gets.chomp.capitalize

puts 'Insert Player 2 Name:'
player_two_name = gets.chomp.capitalize

player_one = Player.new(player_one_name)
player_two = Player.new(player_two_name)

round = Game.new

Player.allocate_letters(player_one, player_two)

puts "#{player_one.name} plays as #{player_one.letter}, #{player_two.name} plays as #{player_two.letter},"

def row_spot
  puts 'Row:'
  num = gets.chomp.to_i
  until num.positive? && num < 4
    puts 'Row:'
    num = gets.chomp.to_i
  end
  num - 1
end

def column_spot
  puts 'Column:'
  num = gets.chomp.to_i
  until num.positive? && num < 4
    puts 'Column:'
    num = gets.chomp.to_i
  end
  num - 1
end

while round.new_game?
  while round.still_play?
    case round.turn
    when player_one.letter
      round.play(player_one, row_spot, column_spot)
    when player_two.letter
      round.play(player_two, row_spot, column_spot)
    end
  end
end
