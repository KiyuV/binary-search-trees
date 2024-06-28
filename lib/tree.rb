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

  def delete(value)
    delete_rec(@root, value)
  end

  def find(value)
    find_rec(@root, value, nil)
  end

  def level_order_iteration
    queue = Array.[](@root)
    result = []

    until queue.empty?
      current_node = queue.shift
      queue << current_node.left unless current_node.left.nil?
      queue << current_node.right unless current_node.right.nil?

      if block_given?
        yield current_node
      else
        result << current_node.data
      end
    end
    result unless block_given?
  end

  def level_order(&block)
    queue = Array.[](@root)
    level_order_rec(queue, &block)
  end

  def inorder(&block)
    inorder_rec(@root, &block)
  end

  def preorder(&block)
    preorder_rec(@root, &block)
  end

  def postorder(&block)
    postorder_rec(@root, &block)
  end

  def height(value)
    node = find(value)
    height_rec(node)
  end

  def depth(value)
    node = find(value)
    depth_rec(@root, node)
  end

  def balanced?
    # an empty tree is a height-balanced tree
    return true if @root.nil?

    left_height = height(@root.left.data)
    right_height = height(@root.right.data)

    (left_height - right_height).abs > 1 ? false : true
  end

  def rebalance
    unless balanced?
      @root = build_tree(inorder)
    end
  end

  private

  def build_tree(array)
    return nil if array.empty?

    sorted_array = array.sort.uniq
    first = 0
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
    end

    root
  end

  def delete_rec(root, value)
    return root if root.nil?

    if value > root.data
      root.right = delete_rec(root.right, value)
    elsif value < root.data
      root.left = delete_rec(root.left, value)
    else
      # node with only one child or no child
      if root.right.nil?
        return root.left
      elsif root.left.nil?
        return root.right
      end

      # node with two children
      # change the data to the minimum of the right subtree
      root.data = min_value(root.right)
      # delete the inorder successor
      root.right = delete_rec(root.right, root.data)
    end

    root
  end

  # finds the minimum value from a given node
  def min_value(node)
    min = node.data
    until node.left.nil?
      min = node.left.data
      node = node.left
    end
    min
  end

  def find_rec(root, value, result)
    # base case
    return result = root if root.nil? || root.data == value

    # recurse right if the value is greater than the root
    if value > root.data
      find_rec(root.right, value, result)
    # recurse left if the value is smaller than the root
    elsif value < root.data
      find_rec(root.left, value, result)
    end
  end

  def level_order_rec(queue = [], result = [], &block)
    return result if queue.empty?

    current_node = queue.shift

    queue << current_node.left unless current_node.left.nil?
    queue << current_node.right unless current_node.right.nil?

    if block_given?
      yield current_node
    else
      result << current_node.data
    end
    level_order_rec(queue, result, &block)
  end

  def inorder_rec(root, result = [], &block)
    return result if root.nil?

    inorder_rec(root.left, result, &block)
    if block_given?
      yield root
    else
      result << root.data
    end
    inorder_rec(root.right, result, &block)
  end

  def preorder_rec(root, result = [], &block)
    return result if root.nil?

    if block_given?
      yield root
    else
      result << root.data
    end
    preorder_rec(root.left, result, &block)
    preorder_rec(root.right, result, &block)
  end

  def postorder_rec(root, result = [], &block)
    return result if root.nil?

    postorder_rec(root.left, result, &block)
    postorder_rec(root.right, result, &block)
    if block_given?
      yield root
    else
      result << root.data
    end
  end

  def height_rec(root)
    # return 0 if the tree is empty or a leaf node was given/reached
    return 0 if root.nil? || root.left.nil? && root.right.nil?

    left_height = height_rec(root.left)
    right_height = height_rec(root.right)

    [left_height, right_height].max + 1
  end

  def depth_rec(root, node)
    # return 0 when there is an empty tree or when the root equals to the target node
    return 0 if node.nil? || root == node

    if node > root
      right_height = depth_rec(root.right, node)
    elsif node < root
      left_height = depth_rec(root.left, node)
    end
    # #compact to remove any nils in the array
    [right_height, left_height].compact.max + 1
  end
end
