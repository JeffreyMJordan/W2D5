require 'byebug'
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new

    @head.next = @tail
    @tail.prev = @head

  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    #byebug
    @head.next==@tail
  end

  def get(key)
    curr = @head
    until curr==nil || curr.key==key
      curr = curr.next
    end
    return curr.val if !curr.nil?
  end

  def include?(key)
    curr = @head
    until curr==nil || curr.key==key
      curr = curr.next
    end
    return true if !curr.nil?
    false
  end

  def append(key, val)
  #byebug
    prev = @tail.prev
    node = Node.new(key, val)
    prev.next = node
    node.prev = prev
    node.next = @tail
    @tail.prev = node
    node
  end

  def update(key, val)
    curr = @head
    until curr==nil || curr.key==key
      curr = curr.next
    end
    curr.val = val if !curr.nil?
  end

  def remove(key)
    curr = @head
    until curr==nil || curr.key==key
      curr = curr.next
    end
    if !curr.nil?
      prev = curr.prev
      n = curr.next
      prev.next = n
      n.prev = prev
    end
  end

  def each
    curr = @head.next
    until curr==@tail
      yield(curr)
      curr = curr.next
    end
  end

  
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
