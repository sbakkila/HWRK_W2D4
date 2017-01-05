require 'byebug'
#find the longest fish in O(n^2) time - basically the same as bubble_sort
def sluggish_octopus(array)
  i = 0
  sorted = false

  until sorted
    sorted = true

    while i + 1 < array.length

      if array[i].length >= array[i+1].length
        array[i], array[i+1] = array[i+1], array[i]
        sorted = false
      end

      i += 1
    end

  end

  array.last
end

#find the longest fish in O(n log n) time
#just use merge_sort, with a proc that compares string length

class Array

  def merge_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y}

    return self if self.length <= 1

    midpoint = self.length / 2
    sorted_left = self.take(midpoint).merge_sort(&prc)
    sorted_right = self.drop(midpoint).merge_sort(&prc)

    Array.merge(sorted_left, sorted_right, &prc)

  end

  private

  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      comparator = prc.call(left.first, right.first)

      if comparator == -1
        merged << left.shift
      else
        merged << right.shift
      end
    end

    merged + left + right
  end
end

def dominant_octopus(array)
  prc = Proc.new { |x, y| x.length <=> y.length}

  array.merge_sort(&prc).last
end



#Clever Octopus
# O(n) time because it holds onto the longest fish while stepping through the array only once
def clever_octopus(array)
  current_longest = [array.first, array.first.length]

  array.each do |fish|
    current_longest = [fish, fish.length] if fish.length > current_longest.last
  end

  return current_longest
end


p sluggish_octopus(['aaa', 'aaaaaaaa', 'a', 'aaaaaaaaaaaaaaaaaaaaaaa', 'a', 'bbbbbbbb'])

p dominant_octopus(['aaa', 'aaaaaaaa', 'a', 'aaaaaaaaaaaaaaaaaaaaaaa', 'a', 'bbbbbbbb'])

p clever_octopus(['aaa', 'aaaaaaaa', 'a', 'aaaaaaaaaaaaaaaaaaaaaaa', 'a', 'bbbbbbbb'])


tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

def slow_dance(direction, tiles_array)
  tiles_array.each_with_index do |tile, index|
    return index if tile == direction
  end
end

TILES = {
  "up" => 0,
  "right-up" => 1,
  "right" => 2,
  "right-down" => 3,
  "down" => 4,
  "left-down" => 5,
  "left" => 6,
  "left-up" => 7
}


def fast_dance(direction, tiles_hash)
  tiles_hash[direction]
end

p fast_dance("up", TILES) #0
p fast_dance("right-down", TILES) #3
