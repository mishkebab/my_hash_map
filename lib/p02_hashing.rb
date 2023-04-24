class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    hashed_str = ''
    self.each_with_index do |ele,idx|
      hashed_str += (idx.to_s + ele.hash.abs.to_s)
    end
    hashed_str.to_i
  end
end

class String
  def hash
    alpha = ("a".."z").to_a
    letters = self.split("")
    nums = letters.map{|ele| alpha.index(ele)}
    nums.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_arr = []
    self.each do |k,v|
      hash_arr << k.hash
      hash_arr << v.hash
    end
    hash_arr.sort.hash
    
  end
end