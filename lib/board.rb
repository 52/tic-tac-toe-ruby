# frozen_string_literal: true

class Board
  def initialize
    reset
  end

  def reset
    @cells = (0..9).to_a.map! { |i| " #{i} " }
  end

  def update(position, sign)
    @cells[position] = sign
  end

  def display
    system 'clear'

    puts <<-HERE

      #{@cells[1]} | #{@cells[2]} | #{@cells[3]}
      ----+-----+----
      #{@cells[4]} | #{@cells[5]} | #{@cells[6]}
      ----+-----+----
      #{@cells[7]} | #{@cells[8]} | #{@cells[9]}

    HERE
  end
end
