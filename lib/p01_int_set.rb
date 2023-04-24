class MaxIntSet
  attr_reader :max, :store
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    if num > @max || num < 0
      raise "Out of bounds"
    end 
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
  end

  def validate!(num)
  end
end

class IntSet
  attr_reader :store, :size
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @size = @store.length
  end

  def insert(num)
    @store[num % self.size] << num
  end

  def remove(num)
    @store[num % self.size].each_with_index do |ele, idx|
      if ele == num 
        @store[num % self.size][idx] = nil
      end
    end
  end

  def include?(num)
    @store[num % self.size].each do |ele|
      return true if ele == num
    end
    false
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
    if !self.include?(num)
      self[num] << num
      @count += 1
      if @count == self.num_buckets
        self.resize!
      end
    end
  end

  def remove(num)
    self[num].each_with_index do |ele, idx|
      if ele == num
        self[num][idx] = nil
        @count -= 1
      end
    end
  end

  def include?(num)
    self[num].each do |ele|
      return true if ele == num
    end
    false
  end

  private

  def num_buckets
    @store.length
  end

  def resize!  
    temp = Array.new(@count * 2) { Array.new }
    temp_size = temp.length
    @store.each do |bucket|
      bucket.each do |num|
        temp[num % temp_size] << num
      end
    end
    @store = temp
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end
end