require 'minitest/autorun'

class Test3_2 < Minitest::Test
  def test_solution_1
    assert_equal 2, solution([1, -1, 0, 2, 3, 5], 3)
  end

  def test_solution_2
    assert_equal 3, solution([3, 2, 1], 1)
  end

  def test_solution_3
    assert_equal -1, solution([1, 2, 3, 4, -1, -1, -1], 3)
  end

  def test_solution_4
    assert_equal 50, solution([50, -1, 5], 2)
  end

  def test_solution_5
    assert_equal 5, solution([1, -1, 5], 2)
  end
end

class River
  attr_reader :river, :distance, :max_turns, :left_bank, :right_bank

  def initialize(river, distance)
    @river, @distance = river, distance
    @max_turns = river.max

    @left_bank = -1
    @right_bank = river.length
  end

  def cross
    0.upto(max_turns) do |turn|
      current_loc = left_bank

      reached = jump(current_loc, turn)
      return turn if reached
    end

    -1
  end

  def jump(current_loc, turn)
    return true  if current_loc == right_bank
    return false if turn > max_turns

    distance.times do |d|
      new_loc = current_loc + distance - d

      return jump(new_loc, turn) if reached_right_bank?(new_loc) || can_jump?(new_loc, turn)
    end

    false
  end

  def can_jump?(to, turn)
    river[to] &&
      river[to] > -1 &&
      river[to] <= turn
  end

  def reached_right_bank?(current_loc)
    current_loc == right_bank
  end
end

def solution(river, d)
  River.new(river, d).cross
end
