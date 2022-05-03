# frozen_string_literal: true

require 'set'
require_relative 'player'
require_relative 'board'
require_relative 'colorable'

class TicTacToe
  extend Colorable

  PLAYER1_SIGN = red_background(' X ')
  PLAYER2_SIGN = green_background(' O ')

  def initialize
    @number_of_games = 0
    @board = Board.new

    player1 = Player.new(PLAYER1_SIGN)
    player2 = Player.new(PLAYER2_SIGN, player1)
    player1.opponent = player2
    @players = [player1, player2]
  end

  def play
    first_time_setup

    @players.cycle do |who_goes_first|
      new_game(who_goes_first)
      continue_to_play = true

      loop do
        print 'Continue to play? [y/N]: '
        answer = gets.chomp.downcase

        continue_to_play = case answer
                           when 'y' then true
                           when 'n' then false
                           end
        break if %(y n).include?(answer)
      end

      break unless continue_to_play
    end
  end

  private

  def first_time_setup
    puts "\nLet's play Tic Tac Toe!\n\n"
    loop do
      print "#{@players[0].sign} Player #1's name (Must not be empty): "
      @players[0].name = gets.chomp
      break unless @players[0].name.empty?
    end
    loop do
      print "#{@players[1].sign} Player #2's name (Must not be \"#{@players[0].name}\" or empty): "
      @players[1].name = gets.chomp
      break unless @players[1].name.empty? || @players[1].name.downcase == @players[0].name.downcase
    end
  end

  def new_game(who_goes_first)
    reset_before_new_game
    @number_of_games += 1
    next_turn(who_goes_first)
  end

  def reset_before_new_game
    @game_finished = false

    @players.each(&:reset)

    @board.reset
    @board.display
  end

  def next_turn(player)
    cell = 0

    until @board.valid_move?(cell)
      print "#{player.sign} #{player.name}'s turn (Enter a number from 1 to 9): "
      cell = gets.chomp.to_i
    end

    player.move(cell)
    @board.update(cell, player.sign)

    @board.display
    check_game_status

    next_turn(player.opponent) unless @game_finished
  end

  def check_game_status
    @game_finished = true

    if @players[0].won?
      puts "#{@players[0].name} won!"
    elsif @players[1].won?
      puts "#{@players[1].name} won!"
    elsif @board.full?
      puts "It's a draw!"
    else
      @game_finished = false
    end

    display_scoreboard if @game_finished
  end

  def display_scoreboard
    puts <<-HERE

      SCOREBOARD:

          #{@players[0].name} #{@players[0].sign} #{@players[0].score} - #{@players[1].score} #{@players[1].sign} #{@players[1].name}

          Draw: #{@number_of_games - @players[0].score - @players[1].score}

    HERE
  end
end
