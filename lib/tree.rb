# frozen_string_literal: true

require './lib/node'

class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value)
    @root = insert_rec(@root, value)
  end

  private

  def build_tree(array)
    sorted_array = array.sort.uniq!
    first = 0
    return nil if array.empty?

    last = sorted_array.length - 1

    balanced_bst(sorted_array, first, last)
  end

  def balanced_bst(array, first, last)
    return nil if first > last

    mid_point = (first + last) / 2
    root = Node.new(array[mid_point])

    root.left = balanced_bst(array, first, mid_point - 1)
    root.right = balanced_bst(array, mid_point + 1, last)

    root
  end

  def insert_rec(root, value)
    return root = Node.new(value) if root.nil?

    if value > root.data
      root.right = insert_rec(root.right, value)
    elsif value < root.data
      root.left = insert_rec(root.left, value)
    # prevent duplicate nodes from being insterted
    else
      puts "#{value} already exists"
      root
    end

    root
  end
end
