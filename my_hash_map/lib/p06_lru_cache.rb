require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if !@map.include?(key)
      value = @prc.call(key)
      node = @store.append(key, value)
      @map[key] = node
      if count>@max
        eject!
      end
      value
    else
      node = @map[key]
      value = node.val
      update_node!(node)
      value
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    @store.remove(node.key)
    @map[node.key] = @store.append(node.key, node.val)

  end

  def eject!

    node = @store.first
    @store.remove(node.key)
    @map.delete(node.key)
  end
end
