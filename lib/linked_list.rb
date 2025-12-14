# frozen_string_literal: true

require_relative 'node'

class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def add(key, value)
    node = Node.new(key, value)
    self.head = node unless head
    tail.next_node = node if tail
    self.tail = node
    node
  end

  def size
    size = 0
    current_node = head
    until current_node.nil?
      size += 1
      current_node = current_node.next_node
    end
    size
  end

  def keys
    keys = []
    current_node = head
    until current_node.nil?
      keys << current_node.key

      current_node = current_node.next_node
    end
    keys
  end

  def values
    values = []
    current_node = head
    until current_node.nil?
      values << current_node.value

      current_node = current_node.next_node
    end
    values
  end

  def nodes
    current_node = head
    nodes = []
    until current_node.nil?
      nodes << [current_node.key, current_node.value]

      current_node = current_node.next_node
    end
    nodes
  end

  def contains?(key)
    return true if find(key)

    false
  end

  def find(key)
    current_node = head
    until current_node.nil?
      return current_node if current_node.key.eql? key

      current_node = current_node.next_node
    end
  end

  def remove(key)
    node = find(key)
    return unless node

    if node.eql? head
      remove_head(node)
    else
      previous_node = previous_node(node)
      previous_node.next_node = node.next_node
      self.tail = previous_node if tail.eql? node
    end
    node.value
  end

  private

  def previous_node(node)
    current_node = head

    until current_node.nil?
      return current_node if current_node.next_node == node

      current_node = current_node.next_node
    end
  end

  def remove_head(node)
    self.head = node.next_node || nil
    self.tail = nil if node.eql? tail
  end

  attr_accessor :head, :tail
end
