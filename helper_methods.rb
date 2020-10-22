module Helper
  def self.match_all(arr, type)
    if type.class == Regexp
      arr.my_each do |ele|
        return false unless type.match(ele.to_s)
      end
      true
    elsif type.class == Class
      arr.my_each do |ele|
        return false unless ele.is_a?(type)
      end
      true
    else
      arr.my_each do |ele|
        return false unless (ele == type)
      end
      true
    end
  end

  def self.match_any(arr, type)
    if type.class == Regexp
      arr.my_each do |ele|
        return true if type.match(ele.to_s)
      end
      false
    elsif type.class == Class
      arr.my_each do |ele|
        return true if ele.is_a?(type)
      end
      false
    else
      arr.my_each do |ele|
        return true if (ele == type)
      end
      false
    end
  end

  def self.match_none(arr, type)
    if type.class == Regexp
      arr.my_each do |ele|
        return false if type.match(ele.to_s)
      end
      true
    elsif type.class == Class
      arr.my_each do |ele|
        return false if ele.is_a?(type)
      end
      true
    else
      arr.my_each do |ele|
        return false if (ele == type)
      end
      true
    end
  end

  def self.no_block(arr, param)
    arr = *arr
    if param.length == 1
      proc = param[0].to_proc # converts symbol into a proc object
      accumulator = first
      (1..(arr.size - 1)).my_each do |indx|
        accumulator = proc.call(accumulator, arr[indx])
      end
      accumulator
    elsif param.length == 2
      proc = param[1].to_proc # converts symbol into a proc object
      accumulator = param[0]
      arr.my_each do |ele|
        accumulator = proc.call(accumulator, ele)
      end
      accumulator
    end
  end
end
