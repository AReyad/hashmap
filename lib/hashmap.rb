# frozen_string_literal: true

require_relative 'linked_list'
require_relative 'node'

class HashMap
  DEFAULT_CAPACITY = 16
  def initialize
    @capacity = DEFAULT_CAPACITY
    @buckets = Array.new(capacity)
    @load_factor = 0.75
    @entries_count = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code % capacity
  end

  def set(key, value)
    return unless key.is_a?(String)

    return change_value(key, value) if has?(key)

    hash_code = hash(key)

    unless buckets[hash_code]
      linkedlist = LinkedList.new
      buckets[hash_code] = linkedlist
    end

    buckets[hash_code].add(key, value)
    self.entries_count += 1
    grow
  end

  def has?(key)
    hash_code = hash(key)
    return false unless buckets[hash_code]&.contains?(key)

    true
  end

  def get(key)
    hash_code = hash(key)
    return unless buckets[hash_code]

    buckets[hash_code].find(key)&.value
  end

  def remove(key)
    hash_code = hash(key)
    return unless buckets[hash_code]&.find(key)

    self.entries_count -= 1
    buckets[hash_code].remove(key)
  end

  def keys
    keys = []
    buckets.each do |bucket|
      next if bucket.nil?

      keys += bucket.keys
    end
    keys
  end

  def values
    values = []
    buckets.each do |bucket|
      next if bucket.nil?

      values += bucket.values
    end
    values
  end

  def entries
    entries = []
    buckets.each do |bucket|
      next if bucket.nil?

      entries += bucket.nodes
    end
    entries
  end

  def length
    self.entries_count
  end

  def clear
    self.capacity = DEFAULT_CAPACITY
    self.entries_count = 0
    self.buckets = Array.new(capacity)
    self
  end

  private

  def growable?
    entries_count > load_factor * capacity # 0.75 * 16 = 12
  end

  def grow
    return unless growable?

    self.capacity = capacity * 2 # 16 * 2 = 32
    self.entries_count = 0
    current_entries = entries
    self.buckets = Array.new(capacity)

    current_entries.each do |entry|
      set(entry[0], entry[1]) # entry = [key, value]
    end

    self
  end

  def change_value(key, value)
    buckets[hash(key)].find(key).value = value
  end

  attr_reader :load_factor
  attr_accessor :entries_count, :capacity, :buckets
end
