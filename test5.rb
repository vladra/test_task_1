require 'minitest/autorun'

class Test3_2 < Minitest::Test
  def test_solution_1
    points = [
      Point2D.new(0, 0),
      Point2D.new(1, 1),
      Point2D.new(2, 2),
      Point2D.new(3, 3),
      Point2D.new(3, 2),
      Point2D.new(4, 2),
      Point2D.new(5, 1)
    ]

    assert_equal 6, solution(points)
  end
end

class Point2D
  attr_reader :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end
end

def solution(points)
  total = 0
  found = []

  points.each.with_index do |p1, i1|
    points[(i1 + 1)..-1].each.with_index do |p2, i2|
      points[(i1 + i2 + 2)..-1].each do |p3|
        if collinear?(p1, p2, p3)
          total += 1
          found << [[p1.x, p1.y], [p2.x, p2.y], [p3.x, p3.y]]
        end
      end
    end
  end

  total > 100_000_000 ? -1 : total
end

def collinear?(p1, p2, p3)
  (p1.x * (p2.y - p3.y) + p2.x * (p3.y - p1.y) + p3.x * (p1.y - p2.y)) == 0
end
