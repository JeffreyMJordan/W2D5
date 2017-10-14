require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    idx = key.hash % @store.length
    @store[idx].include?(key)
  end

  def set(key, val)
    idx = key.hash % @store.length
    list = @store[idx]
    if list.include?(key)
      list.update(key, val)
    else
      @count += 1
      list.append(key, val)
      if @count>@store.length
        resize!
      end
    end
  end

  def get(key)
    idx = key.hash % @store.length
    list = @store[idx]
    list.get(key)
  end

  def delete(key)
    @count -= 1
    idx = key.hash % @store.length
    list = @store[idx]
    list.remove(key)
  end

  def each
    @store.each do |list|
      list.each do |node|
        yield(node.key, node.val)
      end
    end
  end



  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(@store.length*2) { LinkedList.new }
    @store.each do |list|
      list.each do |node|
        idx = node.key.hash % new_store.length
        new_store[idx].append(node.key, node.val )
      end
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
