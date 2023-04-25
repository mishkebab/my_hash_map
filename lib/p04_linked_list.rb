class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
  def inspect
    {"key" => @key, "value" =>@val }.inspect
  end


  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end

end

class LinkedList
  attr_accessor :head, :tail
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end
  def print
    self.each{|node| p node}
    true
  end


  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def include?(key)
    node_check = @head
    while node_check != @tail
      if node_check.next.key == key
        return true  
      else node_check = node_check.next
      end 
    end
    false 
  end

  def append(key, val)
    prev_node = @tail.prev
    new_node = Node.new(key, val)
    prev_node.next = new_node
    @tail.prev = new_node
    new_node.next = @tail
    new_node.prev = prev_node
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
      end
    end
  end

  def get(key)
    self.each do |node|
      if node.key == key
        return node.val
      end
    end
  end 

  def remove(key)
    self.each do |node|
      if node.key == key
        prev_node = node.prev
        next_node = node.next
        prev_node.next = next_node
        next_node.prev = prev_node
      end
    end
  end

  def each(&prc)
    current_node = @head.next
    while current_node != @tail
      prc.call(current_node)
      current_node = current_node.next
    end 
    # self
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end