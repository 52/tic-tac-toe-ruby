# frozen_string_literal: true

# Contain helper methods to display text in colors
module Colorable
  # ANSI color code
  # See:
  # https://stackoverflow.com/questions/1489183/how-can-i-use-ruby-to-colorize-the-text-output-to-a-terminal
  # https://gist.github.com/michaelminter/3918696
  RED_BACKGROUND = "\e[41m"
  GREEN_BACKGROUND = "\e[42m"
  CLEAR = "\e[0m"

  def red_background(text)
    "#{RED_BACKGROUND}#{text}#{CLEAR}"
  end

  def green_background(text)
    "#{GREEN_BACKGROUND}#{text}#{CLEAR}"
  end
end
