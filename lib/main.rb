# frozen_string_literal: true

require './lib/node'
require './lib/tree'

class Main
  def initialize
    @tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
  end

  def run
    @tree.pretty_print
  end
end

main = Main.new
main.run
