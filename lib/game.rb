# frozen_string_literal: true

# This holds the game
class Game
  attr_reader :board, :turn, :plays

  def initialize
    @board = Array.new(3) do
      Array.new(3)
    end
    @turn = 'X'
    @plays = 0
  end

  def play(player, row, column)
    case player.letter
    when @turn
      move(player, row, column)
      ch_turn(%w[X O].reject { |chr| chr == player.letter }[0])
      ch_plays
      puts board.map(&:to_s)
      game_won(player)
    else
      puts 'Not Your Turn'
    end
  end

  def still_play?
    if plays < 9
      true
    else
      p 'GAME OVER!!!'
      @board = Array.new(3) { Array.new(3) }
      false
    end
  end

  def new_game?
    puts 'Play new game? New Game (Y), No Any Key'
    return false unless gets.chomp.upcase == 'Y'

    @plays = 0
    true
  end

  private

  def ch_turn(letter)
    @turn = letter
  end

  def ch_plays
    @plays += 1
  end

  protected

  def move(player, row, column)
    if board[row][column].nil?
      board[row][column] = player.letter
    else
      puts 'Occupied Spot!!! Choose Another Spot'
    end
  end

  def horizontal_win?(player)
    board.map { |row| row.all? { |x| x == player.letter } }.select { |x| x == true }[0]
  end

  def diagonal_win?(player)
    arr1 = [0, 1, 2].map { |num| board[num][num] }
    arr2 = [2, 1, 0].map.with_index { |num, i| board[i][num] }
    arr1.all? { |x| x == player.letter } || arr2.all? { |x| x == player.letter }
  end

  def vertical_win?(player)
    arr1 = [0, 1, 2].map { |i| [0, 1, 2].map { |x| board[x][i] }.all? { |x| x == player.letter } }
    arr1.any? { |x| x == true }
  end

  def win?(player)
    horizontal_win?(player) || vertical_win?(player) || diagonal_win?(player)
  end

  def game_won(player)
    return unless win?(player)

    p "#{player.name.upcase} WINS!!!"
    @board = Array.new(3) { Array.new(3) }
    @plays = 11
  end
end
