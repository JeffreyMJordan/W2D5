require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    @count += 1
    if @count>@store.length
      resize!
    end
    idx = key.hash % @store.length
    @store[idx] << key
  end

  def include?(key)
    idx = key.hash % @store.length
    @store[idx].include?(key)
  end

  def remove(key)
    idx = key.hash % @store.length
    @store[idx].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(@store.length*2) { Array.new }
    @store.each do |bucket|
      bucket.each do |item|
        idx = item%new_store.length
        new_store[idx] << item
      end
    end
    @store = new_store
  end
end
