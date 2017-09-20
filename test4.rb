require 'minitest/autorun'

class Test < Minitest::Test
  def test_solution_1
    matrix = [
      [1, 2, 1, 2, 1, 2],
      [3, 4, 3, 4, 3, 4],
      [1, 2, 1, 2, 1, 2],
      [3, 4, 3, 4, 3, 4]
    ]

    assert_equal 6, solution(matrix)
  end

  def test_solution_2
    matrix = [
      [2, 4, 6, 8, 10, 12],
      [3, 6, 9, 12, 15, 18],
      [4, 8, 12, 16, 20, 24],
      [5, 10, 15, 20, 25, 30]
    ]

    assert_equal 0, solution(matrix)
  end
end

class MatrixUtils
  def initialize(matrix)
    @matrix = matrix
    @n = matrix.size    # rows
    @m = matrix[0].size # cols
  end

  attr_reader :matrix, :n, :m

  def cycling_shifts_count
    count = 0
    matrix.each.with_index do |row, i|
      shifts = find_num_pairs(row, i).map do |args|
        cyclic_shift?(**args) ? 1 : 0
      end

      count += shifts.reduce(0, :+)
    end

    count
  end

  private

  def cyclic_shift?(p:, q:, k:, l:)
    return false unless p < n && k < n
    return false unless q < m && l < m

    matrix[(k + p) % n][l] == matrix[k][l] &&
      matrix[k][(l + q) % m] == matrix[k][l]
  end

  def find_num_pairs(row, p)
    # first we find same numbers and their indexes:
    # { 1 => [0, 1, 3], 2 => [1, 3, 5] }
    indexes = Hash.new { [] }
    row.each.with_index do |el, i|
      next if i == (m - 1)
      indexes[el] = indexes[el] << i
    end

    indexes.delete_if { |_, v| v.size < 2 }

    # Then transform found numbers to this form:
    # [
    #   {p: 0, q: 2, k: 1, l: 1},
    #   {p: 0, q: 4, k: 1, l: 1},
    #   ...
    # ]
    indexes.reduce([]) do |memo, (num, idxs)|
      iargs = idxs.map do |q|
        { p: p, q: q, k: num, l: num }
      end

      memo.concat(iargs)
    end
  end
end

def solution(matrix)
  MatrixUtils.new(matrix).cycling_shifts_count
end
