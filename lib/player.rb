# frozen_string_literal: true

# This holds player infomation
class Player
  def initialize(name)
    @name = name
  end

  attr_accessor :letter

  def self.allocate_letters(player_one, player_two)
    player_one.letter = 'X'
    player_two.letter = 'O'
  end
end
