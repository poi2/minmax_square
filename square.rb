# START: 3/28 00:13

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
  # 与えられた点を含む四角形の座標を左下、右下、右上、左上の順に返す
  max_x = dots.transpose.first.max
  min_x = dots.transpose.first.min
  max_y = dots.transpose.last.max
  min_y = dots.transpose.last.min
  [
    [min_x, min_y],
    [max_x, min_y],
    [max_x, max_y],
    [min_x, max_y],
  ]
end
