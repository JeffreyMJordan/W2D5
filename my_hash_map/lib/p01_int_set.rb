class MaxIntSet
  def initialize(max)
    @store = Array.new(max) {false}
  end

  def insert(num)
    raise "Out of bounds" if is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
     num < 0 || num > @store.length
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    idx = num%20
    @store[idx] << num
  end

  def remove(num)
    idx = num%20
    @store[idx].delete(num)
  end

  def include?(num)
    idx = num%20
    @store[idx].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if (@count+1>=@store.length)
      resize!
    end
    idx = num % @store.length
    if !@store[idx].include?(num)
      @store[idx] << num
      @count += 1
    end
  end

  def remove(num)

    idx = num % @store.length
    if @store[idx].include?(num)
      @store[idx].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    idx = num % @store.length
    @store[idx].include?(num)
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
