# frozen_string_literal: true

class Player
  attr_reader :name, :letter, :score

  def initialize(name, letter)
    @name = name
    @letter = letter
    @score = 0
  end

  def update_score
    @score += 1
  end
end
