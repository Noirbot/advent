require 'json'

class String
    def is_i?
       /\A[-+]?\d+\z/ === self
    end
end

file = File.read('data.txt')

data = JSON.parse(file)

def count(element)
  sum = 0;
  case element
  when Hash
    if element.has_value? 'red'
      return 0
    else
      element.each { |key, value| sum = sum + count(value) }
    end
  when Array
    element.each { |value| sum = sum + count(value) }
  when Fixnum
    sum = sum + element
  end
  return sum
end


puts count(data)
