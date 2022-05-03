# frozen_string_literal: true

class Board
  def initialize
    reset
  end

  def reset
    @cells = (0..9).to_a.map! { |i| " #{i} " }
    @available_cells = (1..9).to_set
  end

  def update(position, sign)
    @cells[position] = sign
    @available_cells.delete(position)
  end

  def valid_move?(cell)
    valid = @available_cells.include?(cell)

    if cell >= 1 && cell <= 9 && !valid
      puts "\nCell number #{cell} is already taken. Please choose another number.\n\n"
    end

    valid
  end

  def full?
    @available_cells.empty?
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
