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
