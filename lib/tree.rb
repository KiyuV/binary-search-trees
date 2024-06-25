# frozen_string_literal: true

require './lib/node'

class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def build_tree(array)
    sorted_array = array.sort.uniq!
    first = 0
    last = sorted_array.length - 1

    balanced_bst(sorted_array, first, last)
  end

  def balanced_bst(array, first, last)
    return nil if first > last

    mid_point = (first + last) / 2
    root = Node.new(array[mid_point])

    root.left = balanced_BST(array, first, mid_point - 1)
    root.right = balanced_BST(array, mid_point + 1, last)

    root
  end
end
