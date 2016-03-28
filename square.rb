# 1 START: 3/28 00:13
# 1 END:   3/28 01:10
# 2 START: 3/28 23:37
# 2 END:   3/29 00:35

args = "3:Oh,Be,AF,in,eG,ir,l5,Q8,mC,7T,Ty,tT"
element, *dots = args.split(/[:,]/)

def euclidlize di_str
  [numlize(di_str[0]), numlize(di_str[1])]
end

DECODER = [*("0".."9"), *("A".."Z"), *("a".."z")]
def numlize str
  DECODER.find_index(str)
end

def min_wrapping_square_coordinate dots
  # 与えられた点を含む最小の四角形の、x, yの最大値、最小値をそれぞれ返す
  max_x = dots.transpose.first.max
  min_x = dots.transpose.first.min
  max_y = dots.transpose.last.max
  min_y = dots.transpose.last.min
  {
    min_x: min_x,
    max_x: max_x,
    min_y: min_y,
    max_y: max_y,
  }
end

def square_to_area sq
  (sq[:max_x] - sq[:min_x] + 1) * (sq[:max_y] - sq[:min_y] + 1)
end

def enclosed? sq, xy
  # squareにxyが含まれるかどうか
  x, y = xy[0], xy[1]
  return true if sq[:min_x] <= x && x <= sq[:max_x] &&
                 sq[:min_y] <= y && y <= sq[:max_y]
  return false
end

def calc_min_square_area args
  element, *dots = args.split(/[:,]/)
  min_area = 62 * 62
  min_cluster = nil
  element = element.to_i

  coords = dots.map{ |dot| euclidlize(dot) }
  sets = coords.combination(element).to_a; nil

  sets.each do |cluster|
    sq = min_wrapping_square_coordinate(cluster)
    area = square_to_area(sq)
    if area < min_area
      enclosed = (coords - cluster).any? do |xy|
        enclosed?(sq, xy)
      end
      unless enclosed
        min_area = area
        min_cluster = cluster
      end
    end
  end

  p "min_area: #{min_area}"
  p "min_cluster: #{min_cluster}"
end
