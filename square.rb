# 1 START: 3/28 00:13
# 1 END:   3/28 01:10
# 2 START: 3/28 23:37
# 2 END:   3/29 00:35

args = "3:Oh,Be,AF,in,eG,ir,l5,Q8,mC,7T,Ty,tT"
# args = "3:00,zz,0z,z0"
# args = "1:ho"
# args = "2:am"
# args = "13:Lk,y3,uO,Gk,sF,7y,ED,FP,rK,vw,Lo,kT,ib,MR,sC,Cu,xQ"
# args = "7:6Q,av,UZ,0c,IV,fo,Vv,mg,no,qM,06,zy,jW,R0,Qo,sK,wQ,1b,De,Iy,zI,cx,rn,ot,cN,45"
# args = "8:zN,2J,ta,HL,Dg,up,Qn,W8,8K,k4,Is,uL,dT,tA,PN,UQ,DB,gA,OO,lv,4h,Rv,D6,23,Tg,4S,Zb"
# args = "5:px,sp,cr,dB,fz,65,gq,zb,sN,42,o0,y3,iE,pv,sn,Al,RE,48,l0,7X,DE,xL,wC,qQ,w5,C3,P3,i1"

# fail
# args = "9:Ic,Dk,Ef,6R,GK,NZ,76,L0,oQ,9f,S3,oL,lX,7v,8d,pX,dZ,z7,zx,fR,pe,w7,aj,U9,lO,kv,wL,s0"
# args = "11:lQ,EN,vO,tn,qO,F3,9k,K2,UC,P0,XY,DB,QO,ps,hy,fl,Dt,ex,Vc,vF,Pf,Vk,uo,Xc,Sh,KE,9g,3H,l6"
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
