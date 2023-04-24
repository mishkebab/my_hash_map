class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !self.include?(key)
      self[key.hash] << key
      @count += 1
      if @count == self.num_buckets
        self.resize!
      end
    end
  end

  def include?(key)
    self[key.hash].each do |ele|
      return true if ele == key
    end
    false
  end

  def remove(key)
    self[key].each_with_index do |ele, idx|
      if ele == key
        self[key][idx] = nil
        @count -= 1
      end
    end
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
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end
end