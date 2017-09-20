require 'minitest/autorun'

class Test3_1 < Minitest::Test
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

def solution(river, d)
  left_bank = -1
  right_bank = river.length
  max_turns = river.max
  time = nil

  0.upto(max_turns) do |turn|
    loc = left_bank

    while loc < right_bank
      cant_finish = false

      d.times do |i|
        new_loc = loc + d - i
        if right_bank == new_loc || (river[new_loc] && river[new_loc] >= 0 && river[new_loc] <= turn)
          break loc = new_loc
        end
        cant_finish = true if d - i == 1
      end

      break if cant_finish
      break time = turn if loc == right_bank
    end

    break if time

    turn += 1
  end

  time || -1
end
