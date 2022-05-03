# frozen_string_literal: true

require 'set'

class Player
  WIN_COMBIMATIONS = Set[
    Set[1, 2, 3],
    Set[4, 5, 6],
    Set[7, 8, 9],
    Set[1, 4, 7],
    Set[2, 5, 8],
    Set[3, 6, 9],
    Set[1, 5, 9],
    Set[3, 5, 7]
 ]

  attr_accessor :name, :opponent, :score
  attr_reader :sign

  def initialize(sign, opponent = nil)
    @sign = sign
    @cells = Set.new
    @opponent = opponent
    @score = 0
  end

  def move(cell)
    @cells.add(cell)
  end

  def won?
    won = WIN_COMBIMATIONS.any? { |win_combination| win_combination.subset?(@cells) }
    @score += 1 if won
    won
  end

  def reset
    @cells.clear
  end
end
