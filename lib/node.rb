# frozen_string_literal: true

class Node
  def initialize(key, value)
    @key = key
    @value = value
    @next_node = nil
  end
  attr_reader :key
  attr_accessor :next_node, :value
end
