# frozen_string_literal: true

require './lib/tree'

class Main
  def initialize
    @tree = Tree.new(Array.new(15) { rand(1..100) })
  end

  def run
    @tree.balanced? # -> true

    puts "preorder:\n #{@tree.preorder}"
    puts
    puts "postorder:\n #{@tree.postorder}"
    puts
    puts "inorder:\n #{@tree.inorder}"
    puts

    @tree.insert(160)
    @tree.insert(153)
    @tree.insert(171)
    @tree.insert(190)

    @tree.balanced? # -> false
    @tree.rebalance
    @tree.balanced? # -> true

    puts 'After rebalance:'
    puts "\npreorder:\n #{@tree.preorder}"
    puts
    puts "postorder:\n #{@tree.postorder}"
    puts
    puts "inorder:\n #{@tree.inorder}"
    puts
  end
end

main = Main.new
main.run
