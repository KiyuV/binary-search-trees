# frozen_string_literal: true

require './lib/node'
require './lib/tree'

class Main
  def initialize
    @tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
    # @tree = Tree.new([])
  end

  def run
    @tree.insert(6345)
    @tree.insert(1)
    @tree.insert(3)
    @tree.insert(25)
    @tree.insert(22)
    @tree.insert(2)
    @tree.insert(323)
    @tree.pretty_print
    puts "\n- - - - - - - - - -"
    puts
    @tree.delete(8)
    @tree.pretty_print
  end
end

main = Main.new
main.run
