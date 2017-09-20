require 'minitest/autorun'

class Test2 < Minitest::Test
  def test_solution_1
    tree1 = Tree.new(
      5,
      Tree.new(
        3,
        Tree.new(
          20,
          Tree.new(6, nil, nil),
          nil
        ),
        nil
      ),
      Tree.new(
        10,
        Tree.new(1, nil, nil),
        Tree.new(
          15,
          Tree.new(
            30,
            nil,
            Tree.new(9, nil, nil)
          ),
          Tree.new(8, nil, nil)
        )
      )
    )

    assert_equal 2, solution(tree1)
  end

  def test_solution_2
    tree2 = Tree.new(
      1,
      Tree.new(
        :l2,
        nil,
        Tree.new(
          :r3,
          Tree.new(:l4, nil, nil),
          Tree.new(
            :r4,
            Tree.new(
              :l5,
              Tree.new(:l6, nil, nil),
              Tree.new(
                :r6,
                Tree.new(:l7, nil, nil),
                nil
              )
            ),
            Tree.new(:r5, nil, nil)
          )
        )
      ),
      Tree.new(
        2,
        nil,
        Tree.new(
          3,
          nil,
          Tree.new(
            4,
            Tree.new(
              5,
              Tree.new(6, nil, nil),
              nil
            ),
            nil
          )
        )
      )
    )
    assert_equal 4, solution(tree2)
  end
end

class Tree
  attr_reader :x, :l, :r

  def initialize(x, l, r)
    @x, @l, @r = x, l, r
  end
end

def solution(tree)
  count_turns(tree)
end

def count_turns(tree, track = nil, count = 0)
  l_turns = if tree.l
              count_turns(tree.l, :l, track && track == :r ? count + 1 : count)
            else
              count
            end

  r_turns = if tree.r
              count_turns(tree.r, :r, track && track == :l ? count + 1 : count)
            else
              count
            end

  [l_turns, r_turns].max
end
