require 'minitest/autorun'

class Test1 < Minitest::Test
  def test_solution
    assert_equal 1, solution([1, 5, 3, 3, 7])
    assert_equal 0, solution([1, 3, 5, 3, 4])
    assert_equal 0, solution([1, 3, 5, 3, 4, 9])
    assert_equal 1, solution([1, 3, 5, 4, 3, 9, 15])
    assert_equal 1, solution([1, 3, 5])
    assert_equal 1, solution([1, 6, 5, 4, 9, 15])
  end
end

def solution(array)
  length = array.length
  left, right = nil, nil

  # Find left (I) number
  array.each.with_index do |num, i|
    break if length - 1 == i
    break left = i if num > array[i + 1]
  end

  # If left is not found array is already sorted
  return 1 if left.nil?

  # Find right (J) number
  array[left..-1].each.with_index do |num, i|
    if array[left] < num
      right = left + i - 1
      break
    end
  end

  # Swap if both numbers are found
  if left && right
    array[left], array[right] = array[right], array[left]
  end

  # Numbers before left are sorted already, so we don't need to check them again
  (length - left).times do |i|
    i += left
    return 1 if i == length - 1
    return 0 if array[i] > array[i + 1]
  end
end
